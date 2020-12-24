import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:zimvest/new_screens/withdrawals/amount_withdraw_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/wealth_activites.dart';
import 'package:zimvest/widgets/navigation/wealth_more.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';
import 'package:zimvest/widgets/navigation/wealthbox_detail_widget.dart';

class AspireDetailsScreen extends StatefulWidget {
  final SavingPlanModel goal;

  const AspireDetailsScreen({Key key, this.goal}) : super(key: key);
  static Route<dynamic> route(SavingPlanModel goal) {
    return MaterialPageRoute(
        builder: (_) => AspireDetailsScreen(goal: goal,),
        settings:
        RouteSettings(name: AspireDetailsScreen().toStringShort()));
  }
  @override
  _AspireDetailsScreenState createState() => _AspireDetailsScreenState();
}

class _AspireDetailsScreenState extends State<AspireDetailsScreen> with
    AfterLayoutMixin<AspireDetailsScreen> {

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;


  bool transactionsLoading = true;
  List<ProductTransaction> transactions = [];

  @override
  void afterFirstLayout(BuildContext context) async{
    savingViewModel.selectedPlan = widget.goal;
    var result =await  savingViewModel.getTransactionForProduct(
        token: identityViewModel.user.token,
        id: widget.goal.id);
    if(result.error == false){
      transactions = result.data;
      transactionsLoading = false;
    }else{
      transactionsLoading = false;
      transactions = [];
    }

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.kWealth,

      body: Stack(
        children: [
          Positioned(
            top: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: widget.goal,
                  child: CachedNetworkImage(imageUrl: AppStrings.url, height: 150,fit: BoxFit.fill,))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 130,

                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        XMargin(20),
                        Text(widget.goal.planName, style: TextStyle(
                            fontSize: 15, fontFamily: AppStrings.fontBold
                        ),),
                        Spacer(),
                        IconButton(icon: Icon(Icons.more_horiz_rounded, color: AppColors.kPrimaryColor,), onPressed: (){
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
                          Text("Current Balance", style: TextStyle(fontSize: 12,fontFamily: AppStrings.fontNormal),),
                          YMargin(10),
                          MoneyTitleWidget(
                            amount: widget.goal.amountSaved,
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
                                    Icon(Icons.arrow_drop_up_outlined,color: AppColors.kWealthDark,),
                                    Text("${AppStrings.nairaSymbol}${widget.goal.accruedInterest}",
                                      style: TextStyle(fontFamily: AppStrings.fontMedium,fontSize: 11,color: AppColors.kWealthDark),),
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
                                Text("${widget.goal.interestRate}%",
                                  style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontMedium, color: AppColors.kWealthDark),),
                              ],),
                          ],),
                          YMargin(30),
                          Row(children: [
                            Text("Goal", style: TextStyle(fontSize: 14,
                                fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText),),
                            Spacer(),
                            Text("Edit", style: TextStyle(fontSize: 11,
                                fontFamily: AppStrings.fontMedium, color: AppColors.kPrimaryColor))
                          ],),
                          YMargin(15),
                          Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: AppUtils.getBoxShaddow,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            child: Row(children: [
                              CircularPercentIndicator(
                                radius: 70.0,
                                lineWidth: 7.0,
                                animation: true,
                                percent:( double.parse(widget.goal.successRate.replaceAll("%", ""))/100) > 1 ? 0.5:
                                ( double.parse(widget.goal.successRate.replaceAll("%", ""))/100),
                                center: new Text(
                                  "${widget.goal.successRate}",
                                  style:
                                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: AppColors.kPrimaryColor,
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text("${widget.goal.targetAmount}", style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,color: AppColors.kGreyText
                                  ),),
                                  YMargin(8),
                                  Text("Goal Amount", style: TextStyle(fontSize: 11,
                                      fontFamily: AppStrings.fontNormal,color: AppColors.kGreyText
                                  ),),
                                  YMargin(30),
                                  Text(AppUtils.getReadableDate2(widget.goal.maturityDate), style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,color: AppColors.kGreyText
                                  ),),
                                  YMargin(8),
                                  Text("Due Date", style: TextStyle(fontSize: 11,
                                      fontFamily: AppStrings.fontNormal,color: AppColors.kGreyText
                                  ),),
                                  Spacer(),
                                ],),
                              Spacer(),

                            ],),
                          )
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
                                Navigator.of(context).push(AmountWithdrawScreen.route());
                              },
                              child: Container(child: Column(children: [
                                Container(
                                    height:35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColorLight,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(child: SvgPicture.asset("images/new/withdraw.svg", color: AppColors.kPrimaryColor))),
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
                                  child: Center(child: SvgPicture.asset("images/new/pause.svg", color: AppColors.kPrimaryColor))),
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
                        transactionsLoading ? CupertinoActivityIndicator():SizedBox(),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                              return WealthBoxActivities(transactions: transactions,);
                            },isScrollControlled: true);
                          },
                          child: Text("See all", style: TextStyle(fontSize: 11,
                              fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText)),
                        )
                      ],),
                    ),
                    ...List.generate(transactionsLoading ? 0:transactions.length > 4 ? 4:transactions.length, (index) {
                      ProductTransaction trans = transactions[index];
                      return WealthBoxActivity(productTransaction: trans,);
                    })

                  ],
                ),
              ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.7),
                ),
                child: Icon(Icons.navigate_before,color: AppColors.kWhite,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
