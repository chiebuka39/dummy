import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/select_dialog.dart';
import 'package:zimvest/data/models/others/assets.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/others_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/bank_details_modal.dart';
import 'package:zimvest/widgets/buttons.dart';

class StatementOfPersonalWorth extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => StatementOfPersonalWorth(),
        settings: RouteSettings(
            name: StatementOfPersonalWorth().toStringShort()));
  }
  @override
  _StatementOfPersonalWorthState createState() => _StatementOfPersonalWorthState();
}

class _StatementOfPersonalWorthState extends State<StatementOfPersonalWorth>
    with AfterLayoutMixin<StatementOfPersonalWorth>,SingleTickerProviderStateMixin {
  ABSIdentityViewModel identityViewModel;
  ABSOthersViewModel othersViewModel;
  List<Asset> assets;
  List<Asset> liabillities;
  TabController _tabController;

  List<Asset> selectedAssets = [];
  List<Asset> selectedLiabillities = [];

  bool assetShowing = true;
  
  List<double> assetsSummary = [];
  List<double> liabillitiesSummary = [];



  @override
  void afterFirstLayout(BuildContext context) async{
    var result = await othersViewModel.getAssetTypes(identityViewModel.user.token, "1");
    var result1 = await othersViewModel.getAssetTypes(identityViewModel.user.token, "2");
    if(result.error == false ){
      assets = result.data;
    }
    if(result1.error == false ){
      liabillities = result1.data;
    }
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        if(_tabController.index == 0){
            assetShowing = true;
        }else{
            assetShowing = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    othersViewModel = Provider.of(context);
    print("assets $selectedAssets");
    print("lia $selectedLiabillities");
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor: AppColors.kBg,
          appBar: ZimAppBarWitButton(
            onTap: assetSumTotal() > 0 || liabilitiesSumTotal() > 0 ? (){
              showCupertinoModalBottomSheet(context: context, builder: (context){
                return _buidModal();
              });
            }:null,
            title: "Statement of Personal Net-worth",
              desc: 'Check your statement of personal net-worth here for free.',
          ),
          bottomNavigationBar: _buildBottomBar(),
          floatingActionButton: _floatingActionBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              TabBar(
                controller: _tabController,
                labelColor: AppColors.kAccountTextColor,
                labelStyle: TextStyle(fontSize: 12,fontFamily: "Caros-Medium"),
                unselectedLabelColor: AppColors.kLightTitleText,
                indicatorColor: AppColors.kAccentColor,
                tabs: [
                  Tab(text: "Assets",),
                  Tab(text: "Liabillities",),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      key: Key("asset"),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          for(var a in selectedAssets)
                            AmountWidgetDropdownBorder(
                              onChangeTitle: (){
                                int index = selectedAssets.indexOf(a);
                                showToReplaceDialog(index, true);
                              },
                              initialValue: assetsSummary[selectedAssets.indexOf(a)].toString(),
                              key: Key("asset ${a.id}"),
                              onChange: (value){
                                int index = selectedAssets.indexOf(a);
                                setState(() {
                                  assetsSummary[index] = value*100;
                                });
                              },
                              textColor: AppColors.kPrimaryColor2,
                              title: a.assetLiabilityName,
                            )
                        ]),
                      ),
                    ),
                    Container(
                      key: Key("liability"),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          for(var a in selectedLiabillities)
                            AmountWidgetDropdownBorder(
                              onChangeTitle: (){
                                int index = selectedLiabillities.indexOf(a);
                                showToReplaceDialog(index, false);
                              },
                              key: Key("liab ${a.id}"),
                              initialValue: liabillitiesSummary[selectedLiabillities.indexOf(a)].toString(),
                              onChange: (value){
                                int index = selectedLiabillities.indexOf(a);
                                setState(() {
                                  liabillitiesSummary[index] = value*100;
                                });
                              },
                              textColor: AppColors.kPrimaryColor2,
                              title: a.assetLiabilityName,

                            )
                        ]),
                      ),
                    ),
                  ],
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }

  Container _buidModal() {
    return Container(
                height: 400,
                color: AppColors.kBg,
                width: double.infinity,
                child: Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      YMargin(33),
                      Row(
                        children: [
                          Spacer(),
                          Text("Your personal net-worth is", style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Caros-Bold",
                            color: AppColors.kPrimaryColor2
                          ),),
                          Spacer(),
                        ],
                      ),
                      YMargin(30),
                      Container(
                        height: 55,
                        width: 240,
                        decoration: BoxDecoration(
                          color: isWorthPositive() ? AppColors.kPrimaryColor2:AppColors.kRed2,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text("NGN ${assetSumTotal()
                              - liabilitiesSumTotal()}",style: TextStyle(fontSize: 25,
                              fontFamily: "Caros-Bold", color: AppColors.kWhite),),
                        ),
                      ),
                      YMargin(33),
                      Text("₦ ${getAmountInString(assetSumTotal())} "
                          "- ₦ ${getAmountInString(liabilitiesSumTotal())}",
                        style: TextStyle(fontFamily: "Caros-Bold", fontSize: 14,
                            color: AppColors.kPrimaryColor),),
                      YMargin(33),
                      SizedBox(
                        width: 300,
                        child: Text( isWorthPositive() ? "You are doing well! The net-worth value here is positive. "
                            "However, we can help you save more.": 'Oops! The net-worth value here is negative, you have 9,000,000 deficit. '
                            'However, we are here to help you fix things.',textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.kAccountTextColor,
                              fontSize: 11),),
                      ),
                      Spacer(),
                      PrimaryButton(
                        horizontalMargin: 20,
                        title: "Chat with a private wealth manager now",
                        onPressed: (){

                        },
                      ),
                      YMargin(30),
                    ],
                  ),
                ),
              );
  }

  double liabilitiesSumTotal() => liabillitiesSummary.isEmpty ? 0.0: liabillitiesSummary.reduce((value, element) => value + element);

  double assetSumTotal() => assetsSummary.isEmpty ? 0.0: assetsSummary.reduce((value, element) => value + element);

  bool isWorthPositive() {
    return assetSumTotal()
                            - liabilitiesSumTotal() > 0;
  }

  FloatingActionButton _floatingActionBar(BuildContext context) {
    return FloatingActionButton(onPressed: () {
        SelectDialog.showModal<Asset>(
          context,
          label:_tabController.index == 0 ?"Select an Asset":"Select a Liability",
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height -200,
              maxWidth: MediaQuery.of(context).size.width * 0.7
          ),
          titleStyle: TextStyle(color: Colors.brown),
          showSearchBox: false,
          itemBuilder: (context,Asset t,b){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                child: Text(t.assetLiabilityName)
            );
          },
          selectedValue: null,
          backgroundColor: Colors.white,
          items: _tabController.index == 0 ?  assets:liabillities,
          onChange: (Asset selected) {
            setState(() {
              if(_tabController.index == 0){
                print("llll i am an asset");
                selectedAssets.add(selected);
                assetsSummary.add(0);
              }else{
                print("llll i am a liabillity");
                selectedLiabillities.add(selected);
                liabillitiesSummary.add(0);
                print(selectedLiabillities);
              }
            });
          },
        );
      },child: Icon(Icons.add),backgroundColor: AppColors.kAccentColor,);
  }

  Container _buildBottomBar() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        color: AppColors.kPrimaryColor,
        child: Center(
          child: AnimatedSwitcher(
            duration: Duration(minutes: 500),
            child: assetShowing == true?  Row(children: [
              Text("TOTAL Assets".toUpperCase(),
                style: TextStyle(
                    color: AppColors.kWhite,
                  fontFamily: "Caros-Bold"
                ),),
              Spacer(),
              Text("\u20A6 ${assetsSummary.isEmpty ? '0.0': getAmountInString(assetSumTotal())}".toUpperCase(),
                style: TextStyle(
                    color: AppColors.kWhite,
                  fontFamily: "Caros-Medium"
                ),)
            ],):Row(children: [
              Text("TOTAL Liabilities".toUpperCase(),
                style: TextStyle(
                    color: AppColors.kWhite,
                    fontFamily: "Caros-Bold"
                ),),
              Spacer(),
              Text("\u20A6 ${liabillitiesSummary.isEmpty ? '0.0':getAmountInString(liabilitiesSumTotal())}".toUpperCase(),
                style: TextStyle(
                    color: AppColors.kWhite,
                    fontFamily: "Caros-Medium"
                ),)
            ],),
          ),
        ),
      );
  }

  String getAmountInString(double value){
    FlutterMoneyFormatter moneyFormatter = FlutterMoneyFormatter(amount: value);
    return moneyFormatter.output.nonSymbol;
  }

  showToReplaceDialog(int index, bool assetsToChoose){
    SelectDialog.showModal<Asset>(
      context,
      label: "Select an Asset",
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -200,
          maxWidth: MediaQuery.of(context).size.width * 0.7
      ),
      titleStyle: TextStyle(color: Colors.brown),
      showSearchBox: false,
      itemBuilder: (context,Asset t,b){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
            child: Text(t.assetLiabilityName)
        );
      },
      selectedValue: selectedAssets[index],
      backgroundColor: Colors.white,
      items: assetsToChoose == true ? assets:liabillities,
      onChange: (Asset selected) {
        setState(() {
          if(assetsToChoose == true){
            selectedAssets[index] = selected;
          }else{
            liabillities[index] = selected;
          }

        });
      },
    );
  }
}
