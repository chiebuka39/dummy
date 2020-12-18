import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_screen.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/navigation/portfolio_screen.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/wealth_activites.dart';
import 'package:zimvest/widgets/navigation/wealth_more.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';
import 'package:zimvest/widgets/navigation/wealthbox_detail_widget.dart';

class WealthBoxDetailsScreen extends StatefulWidget {
  final SavingPlanModel savingsPlanModel;

  const WealthBoxDetailsScreen({Key key, this.savingsPlanModel}) : super(key: key);
  static Route<dynamic> route(SavingPlanModel savingsPlanModel) {
    return MaterialPageRoute(
        builder: (_) => WealthBoxDetailsScreen(savingsPlanModel: savingsPlanModel,),
        settings:
        RouteSettings(name: WealthBoxDetailsScreen().toStringShort()));
  }
  @override
  _WealthBoxDetailsScreenState createState() => _WealthBoxDetailsScreenState();
}

class _WealthBoxDetailsScreenState extends State<WealthBoxDetailsScreen> with AfterLayoutMixin<WealthBoxDetailsScreen> {
  SavingPlanModel savingsPlanModel;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  List<ProductTransaction> transactions;

  @override
  void initState() {
   savingsPlanModel = widget.savingsPlanModel;
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    fetchTransactions(savingsPlanModel.id);
  }

  Future<void> fetchTransactions(int productId) async {


      var result = await savingViewModel.getTransactionForProduct(
          token: identityViewModel.user.token,
          id: productId);
      if(result.error == false){
        setState(() {
          transactions = result.data;
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    // print("ooo ${savingViewModel.savingsTransactions[1]}");
    return Scaffold(
      backgroundColor: AppColors.kWealth,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.height - 130,
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    YMargin(27),
                    Row(
                      children: [
                        XMargin(20),
                        Text(savingsPlanModel.planName, style: TextStyle(
                            fontSize: 15, fontFamily: AppStrings.fontBold
                        ),),
                        Spacer(),
                        IconButton(icon: Icon(Icons.more_horiz_rounded), onPressed: (){
                          showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                            return WealthMore();
                          },isScrollControlled: true);
                        })
                      ],
                    ),
                    YMargin(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Balance", style: TextStyle(fontSize: 12,
                              fontFamily: AppStrings.fontNormal,
                              color: AppColors.kSecondaryText),),
                          YMargin(10),
                          MoneyTitleWidget(
                            amount: savingsPlanModel.amountSaved,
                          ),
                          YMargin(25),
                          Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Accrued Interest",
                                  style: TextStyle(
                                      fontFamily: AppStrings.fontNormal,
                                      color: AppColors.kGreyText,
                                      fontSize: 11
                                  ),),
                                YMargin(4),
                                Transform.translate(
                                  offset: Offset(-8,0),
                                  child: Row(children: [
                                    Icon(Icons.arrow_drop_up_outlined),
                                    Text("${AppStrings.nairaSymbol}${savingsPlanModel.accruedInterest}",
                                      style: TextStyle(fontFamily: AppStrings.fontMedium, color: AppColors.kWealthDark,fontSize: 11),),
                                    XMargin(5),
                                    Text("Past 24h",
                                      style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontNormal),),
                                  ],),
                                )
                              ],),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Interest P.A",
                                  style: TextStyle(
                                      fontFamily: AppStrings.fontNormal,
                                      color: AppColors.kGreyText,
                                      fontSize: 11
                                  ),),
                                YMargin(4),
                                Text("${savingsPlanModel.interestRate}%",
                                  style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontMedium, color: AppColors.kWealthDark),),
                              ],),
                          ],),


                        ],
                      ),
                    ),
                    YMargin(30),
                    Row(

                      children: [
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap:(){
                                savingViewModel.selectedPlan = savingsPlanModel;
                                Navigator.of(context).push(TopUpScreen.route());
                              },
                              child: Container(child: Column(children: [
                                Container(
                                    height:35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColorLight,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: SvgPicture.asset("images/new/top_up.svg", color: AppColors.kPrimaryColor,))),
                                YMargin(12),
                                Text("Top Up", style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal
                                ),)
                              ],),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(WithdrawWealthScreen.route());
                              },
                              child: Container(child: Column(children: [
                                Container(
                                    height:35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColorLight,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: SvgPicture.asset("images/new/top_up.svg",color: AppColors.kPrimaryColor,))),
                                YMargin(12),
                                Text("Withdraw", style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal
                                ),)
                              ],),),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(child: Column(children: [
                              Container(
                                  height:35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: AppColors.kPrimaryColorLight,
                                      shape: BoxShape.circle
                                  ),
                                  child: Center(child: SvgPicture.asset("images/new/top_up.svg",color: AppColors.kPrimaryColor,))),
                              YMargin(12),
                              Text("Pause", style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontNormal
                              ),)
                            ],),),
                          ),
                        ),
                      ],),
                    YMargin(40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text("Activities", style: TextStyle(fontSize: 14,
                            fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText),),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                              return WealthBoxActivities(transactions:savingViewModel.savingsTransactions[savingsPlanModel.productId],);
                            },isScrollControlled: true);
                          },
                          child: Text("See all", style: TextStyle(fontSize: 11,
                              fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText)),
                        )
                      ],),
                    ),
                    ...List.generate( transactions == null ? 0 : transactions.length > 4? 4
                        :transactions.length, (index) {
                      return WealthBoxActivity(productTransaction: transactions[index],);
                    })

                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
