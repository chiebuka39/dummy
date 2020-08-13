import 'package:after_layout/after_layout.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/animations/fab_menu_items.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/screens/tabs/savings/add_fund.dart';
import 'package:zimvest/screens/tabs/savings/create_aspire_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/styles/styles.dart';
import 'package:zimvest/utils/enums.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/line_chart.dart';
import 'package:zimvest/widgets/savings.dart';

import 'create_wealth_box.dart';

class SavingsScreen extends StatefulWidget {
  @override
  _SavingsScreenState createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen>
    with AfterLayoutMixin<SavingsScreen> {
  FlutterMoneyFormatter amount;
  int _zimType;
  bool showSavingsGraph = true;

  bool showFabContainer = false;
  bool showFabContainer2 = false;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;

  List<ProductTransaction> productTransactions = [];

  SavingPlanModel currentSavingPlan;

  @override
  void initState() {
    _zimType = 1;
    amount = FlutterMoneyFormatter(
        amount: 10000000,
        settings: MoneyFormatterSettings(fractionDigits: 0, symbol: "\u20A6"));
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    EasyLoading.show(status: 'loading...');

     var r1 = await savingViewModel.getSavingPlans(token: identityViewModel.user.token);
     var r2 = await savingViewModel.getProductTypes(token: identityViewModel.user.token);
     if(r1.error == false && r2.error == false ){
       if(savingViewModel.productTypes.isNotEmpty){
         await fetchTransactions(savingViewModel.productTypes.first.id);
       }
       EasyLoading.dismiss();

       getRequiredDetailsForForm();
     }else{
       EasyLoading.showError("Error occured");

       getRequiredDetailsForForm();
     }






  }

  Future<void> fetchTransactions(int productId,{bool showLoader = false}) async {
    if(showLoader == true){
      EasyLoading.show(status: 'loading...');
      await savingViewModel.getTransactionForProductType(
          token: identityViewModel.user.token,
          productId: productId);
      EasyLoading.dismiss();

    }else{
      var result = await savingViewModel.getTransactionForProductType(
          token: identityViewModel.user.token,
          productId: productId);
      ;
    }

  }



  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async{
            if(_zimType == 1){
              var result = await Navigator.of(context).push(CreateZimvestWealthBoxScreen.route());
              if(result == true){
                EasyLoading.show(status: 'loading...');
                await fetchTransactions(savingViewModel.productTypes.first.id);
                EasyLoading.dismiss();
              }
            }else{
              Navigator.of(context).push(CreateZimvestAspireScreen.route());
            }

          },
          backgroundColor: AppColors.kAccentColor,
        ),
      ),
      body: Container(
        color: AppColors.kBg,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Spacer(),
                      CircularProfileAvatar(
                        AppStrings.avatar,
                        radius: 17,
                      ),
                      XMargin(20)
                    ],
                  ),
                  YMargin(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "My Savings",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Caros-Bold",
                          color: Color(0xFF0b2328)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 11),
                    child: Text(
                      "You are a zimvest classic client. Are you ready to invest?",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Caros",
                          color: Color(0xFF324d53)),
                    ),
                  ),
                  YMargin(20),
                  buildSavingsType(),
                  YMargin(15),
                  getSavingItem(),
                  YMargin(15),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SavingsActionWidget(
                          title: "Add funds",
                          onTap: (){
                            Navigator.of(context).push(AddFundScreen.route(savingViewModel.savingPlanModel.first));
                          },
                        ),
                        XMargin(5),
                        SavingsActionWidget(
                          title: "Withdraw",
                        )
                      ],
                    ),
                  ),
                  YMargin(20),
                  PauseSavingsWidget(
                    active: false,
                  ),
                  YMargin(15),
                  _buildTrackYourSavingsHeader(),
                  showSavingsGraph == true ? LineChartSample2() : SizedBox(),
                  YMargin(30),
                  _buildSavingsActivities(),
                  YMargin(20),
                ]),
              ),
              savingViewModel.savingsTransactions[_zimType]  == null? SliverToBoxAdapter():SliverList(
                delegate: SliverChildListDelegate(List.generate(
                    savingViewModel.savingsTransactions[_zimType].length > 4
                        ? 4
                        : savingViewModel.savingsTransactions[_zimType].length, (index) {
                  var p = savingViewModel.savingsTransactions[_zimType][index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: .5, color: AppColors.kLightText))),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 55,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.transactionDescription,
                              style: TextStyle(
                                  color: Color(0xFF324d53), fontSize: 12),
                            ),
                            YMargin(5),
                            Text(
                              "Mon, April 13 2020",
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.kLightText2),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${p.amount}",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.kGreen),
                            ),
                            YMargin(5),
                            Text(
                              p.statusText,
                              style: TextStyle(
                                  fontSize: 10, color: AppColors.kLightText2),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildSavingsType() {
    return Row(
      children: savingViewModel.productTypes.map((e) => ZimSelectedButton2(

        title: "Zimvest ${e.productTypeName}",
        onTap: () async{
          if(_zimType == e.id){
            return;
          }
          setState(() {
            _zimType = e.id;
          });
          await fetchTransactions(e.id,showLoader:true );
        },
        type: e.id,
        selectedType: _zimType,
      )).toList(),
    );
  }

  Widget getSavingItem() {
    Widget result;

    if (_zimType == 1) {
      result = savingViewModel.savingPlanModel
                  .where((element) => element.productId == 1)
                  .length ==
              0
          ? SizedBox()
          : SavingsDetailContainer(
              savingPlanModel: savingViewModel.savingPlanModel
                  .where((element) => element.productId == 1)
                  .first,
            );
    } else {
      result = Container(
        height: 140,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: savingViewModel.savingPlanModel
              .where((element) => element.productId != 1)
              .map((e) => SavingsAspireContainer(
                    savingPlanModel: e,
                  ))
              .toList(),
        ),
      );
    }

    return result;
  }

  Widget _buildTrackYourSavingsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Track your savings",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Caros-Bold",
                color: AppColors.kPrimaryColor2),
          ),
          InkWell(
            onTap: () {
              setState(() {
                showSavingsGraph = !showSavingsGraph;
              });
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    "Hide",
                    style: TextStyle(
                        fontFamily: "Caros-Medium",
                        fontSize: 12,
                        color: AppColors.kAccentColor),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 19,
                    color: AppColors.kAccentColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsActivities() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Savings activities",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Caros-Bold",
                color: AppColors.kPrimaryColor2),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                        fontFamily: "Caros-Medium",
                        fontSize: 12,
                        color: AppColors.kAccentColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getRequiredDetailsForForm() {
    savingViewModel.getFundingChannel(token: identityViewModel.user.token);
    savingViewModel.getSavingFrequency(token: identityViewModel.user.token);
    paymentViewModel.getUserCards(identityViewModel.user.token);
    paymentViewModel.getWallet(identityViewModel.user.token);
  }
}

class FabItem extends StatelessWidget {
  final String item;
  const FabItem({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 2),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            item,
            style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ))
        ],
      ),
    );
  }
}

class PauseSavingsWidget extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChange;
  const PauseSavingsWidget({
    Key key,
    this.active,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.kLightText),
              bottom: BorderSide(color: AppColors.kLightText))),
      child: Row(
        children: [
          Text(
            "Pause your savings",
            style: TextStyle(color: Color(0xFF324d53)),
          ),
          Spacer(),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              onChanged: onChange,
              value: active,
              activeColor: AppColors.kAccentColor,
            ),
          )
        ],
      ),
    );
  }
}
