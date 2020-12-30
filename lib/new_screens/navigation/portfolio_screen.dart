import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/portfolio/aspire_widgets.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire_box_details.dart';
import 'package:zimvest/new_screens/navigation/wealth/investment_details.dart';
import 'package:zimvest/new_screens/navigation/widgets/earn_free_cash.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';
import 'package:zimvest/widgets/navigation/wealthbox_detail_widget.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  bool showInvest = false;
  

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Portfolio",
                      style: TextStyle(
                          fontSize: 16, fontFamily: AppStrings.fontBold),
                    ),
                    Spacer(),
                    EarnFreeCashWidget()
                  ],
                ),
              ),
              YMargin(33),
              Row(
                children: <Widget>[
                  Spacer(),
                  Container(
                    width: tabWidth,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColorLight,
                        borderRadius: BorderRadius.circular(13)),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          left: showInvest == true ? tabWidth / 2 : 0,
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            width: tabWidth / 2,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(13)),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showInvest = false;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                  "Savings",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: showInvest == false
                                          ? Colors.white
                                          : AppColors.kPrimaryColor),
                                ))),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showInvest = true;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                  "Investment",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: showInvest == true
                                          ? Colors.white
                                          : AppColors.kPrimaryColor),
                                ))),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              YMargin(30),
            ])),
            showInvest
                ? PortfolioInvestmentWidget()
                : SavingsSection(),
          ],
        ),
      ),
    );
  }
}

class SavingsSection extends StatefulWidget {
  const SavingsSection({
    Key key,
  }) : super(key: key);

  @override
  _SavingsSectionState createState() => _SavingsSectionState();
}

class _SavingsSectionState extends State<SavingsSection> with AfterLayoutMixin<SavingsSection> {
  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  SavingPlanModel wealthBox;
  List<SavingPlanModel> aspirePlans = <SavingPlanModel>[];
  double totalBalance = 0;

  bool loading = false;

  @override
  void afterFirstLayout(BuildContext context)async {

      setState(() {
        loading = true;
      });


      var r1 = await savingViewModel.getSavingPlans(token: identityViewModel.user.token);
      var r2 = await savingViewModel.getProductTypes(token: identityViewModel.user.token);
      if(r1.error == false && r2.error == false ){

        wealthBox =  savingViewModel.savingPlanModel.where((element) => element.productId == 1).isNotEmpty ?
        savingViewModel.savingPlanModel.where((element) => element.productId == 1).first : null;
        aspirePlans = savingViewModel.savingPlanModel.where((element) => element.productId == 2).toList();
        savingViewModel.savingPlanModel.forEach((element) {
          totalBalance = totalBalance + element.amountSaved;
        });

        setState(() {
          loading = false;
        });

        if(savingViewModel.productTypes.isNotEmpty){
          await fetchTransactions(savingViewModel.productTypes.first.id);
        }

        //getRequiredDetailsForForm();
      }








  }

  Future<void> fetchTransactions(int productId,{bool showLoader = false}) async {
    if(showLoader == true){

      await savingViewModel.getTransactionForProductType(
          token: identityViewModel.user.token,
          productId: productId);




    }else{
      var result = await savingViewModel.getTransactionForProductType(
          token: identityViewModel.user.token,
          productId: productId);

    }

  }

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return loading == true ?SavingsInvestmentLoadingWidget(): wealthBox == null && aspirePlans.isEmpty ? SavingsInvestmentWidget():
    SavingsInvestmentCashWidget(wealthBox: wealthBox,aspirePlans: aspirePlans,totalBalance: totalBalance,);
  }
}

class SavingsInvestmentWidget extends StatelessWidget {
  const SavingsInvestmentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        YMargin(MediaQuery.of(context).size.height > 700 ? 200 : 100),
            SvgPicture.asset("images/new/savings_illus.svg"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
                width: 200,
                child: Text(
                  "You currently don’t have a savings plan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kGreyText,
                      height: 1.6),
                )),
          ],
        ),
        YMargin(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonNew(
              title: "Start Saving",
            ),
          ],
        ),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
class SavingsInvestmentLoadingWidget extends StatelessWidget {
  const SavingsInvestmentLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        YMargin(MediaQuery.of(context).size.height > 700 ? 250 : 150),
        CupertinoActivityIndicator(),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class SavingsInvestmentCashWidget extends StatelessWidget {
  const SavingsInvestmentCashWidget({
    Key key, this.wealthBox, this.aspirePlans, this.totalBalance,
  }) : super(key: key);

  final SavingPlanModel wealthBox;
  final double totalBalance;
  final List<SavingPlanModel> aspirePlans;



  @override
  Widget build(BuildContext context) {
    List<SavingPlanModel> goals = [...aspirePlans,SavingPlanModel()];
    List<SavingPlanModel> goals1 = [...aspirePlans,SavingPlanModel()];
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        Text(
          "Total balance",
          style: TextStyle(
              color: AppColors.kGreyText, fontFamily: AppStrings.fontMedium),
        ),
        YMargin(12),
        MoneyTitleWidget(
          amount: totalBalance,
        ),
        YMargin(25),
        wealthBox == null ? SizedBox(): GestureDetector(
          onTap: (){
            Navigator.push(context, WealthBoxDetailsScreen.route(wealthBox));
          },
          child: Container(
            height: 154,
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              boxShadow: AppUtils.getBoxShaddow,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(3),
                Text(wealthBox.planName),
                Spacer(),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppStrings.fontNormal,
                              color: AppColors.kGreyText),
                        ),
                        YMargin(10),
                        Text(
                          "${AppStrings.nairaSymbol}${wealthBox.amountSaved}",
                          style: TextStyle(
                              color: AppColors.kGreyText,
                              fontFamily: AppStrings.fontMedium),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Interest P.A",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppStrings.fontNormal,
                              color: AppColors.kGreyText),
                        ),
                        YMargin(10),
                        Text(
                          "${wealthBox.interestRate}%",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: AppColors.kGreyText,
                              fontFamily: AppStrings.fontMedium),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "Goals",
              style: TextStyle(
                  fontFamily: AppStrings.fontMedium,
                  color: AppColors.kGreyText),
            ),
            XMargin(3),
            Text(
              "(Zimvest aspire)",
              style: TextStyle(
                  fontFamily: AppStrings.fontNormal,
                  color: AppColors.kGreyText,
                  fontSize: 12),
            ),
          ],
        ),
        ...List.generate((goals.length / 2).round(), (index) {
          print("ppmm ${index} >>>> ${(goals.length / 2).round() - 1}");
          if (goals.length.isOdd && ((goals.length / 2).round() - 1) == index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  buildNewGoal(),
                  XMargin(20),
                  Expanded(
                    child: Opacity(
                      opacity: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        height: 154,
                        decoration: BoxDecoration(
                            color: AppColors.kGreyBg,
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (goals.length.isEven && ((goals.length / 2).round() - 1) == index) {
            SavingPlanModel goal = goals1.removeAt(0);
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  AspireContainerWidget(
                    goal: goal,
                  ),
                  XMargin(20),
                  buildNewGoal(),
                ],
              ),
            );
          }
          SavingPlanModel goal1 = goals1.removeAt(0);
          SavingPlanModel goal2 = goals1.removeAt(0);
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                AspireContainerWidget(
                  goal: goal1,
                ),
                XMargin(20),
                AspireContainerWidget(
                  goal: goal2,
                ),
              ],
            ),
          );
        }),
        YMargin(60),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget buildNewGoal() {
    return AspireNewGoalWidget();
  }

  Widget buildAspireContainer() {
    return AspireContainerWidget();
  }
}

class PortfolioInvestmentWidget extends StatefulWidget {
  const PortfolioInvestmentWidget({
    Key key,
  }) : super(key: key);

  @override
  _PortfolioInvestmentWidgetState createState() =>
      _PortfolioInvestmentWidgetState();
}

class _PortfolioInvestmentWidgetState extends State<PortfolioInvestmentWidget> {
  bool naira = true;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          YMargin(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 50,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                naira = true;
                              });
                            },
                            child: Text(
                              "Naira",
                              style: TextStyle(
                                  color: naira
                                      ? AppColors.kPrimaryColor
                                      : AppColors.kTextColor,
                                  fontSize: 12,
                                  fontFamily: naira
                                      ? AppStrings.fontMedium
                                      : AppStrings.fontNormal),
                            )),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                naira = false;
                              });
                            },
                            child: Text("Dollar",
                                style: TextStyle(
                                    color: naira
                                        ? AppColors.kTextColor
                                        : AppColors.kPrimaryColor,
                                    fontSize: 12,
                                    fontFamily: naira
                                        ? AppStrings.fontNormal
                                        : AppStrings.fontMedium))),
                      ],
                    ),
                    AnimatedPositioned(
                        top: 20,
                        left: naira ? 5 : 70,
                        child: Container(
                          height: 3,
                          width: 20,
                          decoration:
                              BoxDecoration(color: AppColors.kPrimaryColor),
                        ),
                        duration: Duration(milliseconds: 300))
                  ],
                ),
              )
            ],
          ),
          naira
              ? EmptyInvstmentWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.kTextColor.withOpacity(0.4)),
                    ),
                    YMargin(12),
                    MoneyTitleWidget(
                      amount: 820000,
                      dollar: true,
                    ),
                    ...List.generate(4, (index) => InvestmentItemWidget()),
                    YMargin(104),
                  ],
                ),
        ]),
      ),
    );
  }
}

class InvestmentItemWidget extends StatelessWidget {
  const InvestmentItemWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, InvestmentDetailsScreen.route());
      },
      child: Container(
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.all(11),
        height: 154,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: AppUtils.getBoxShaddow,
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Child Education",
              style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontMedium),
            ),
            YMargin(8),
            Text(
              "Zimvest high yield Naira 30 days",
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.kTextColor,
                  fontFamily: AppStrings.fontLight),
            ),
            Spacer(),
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Balance", style: TextStyle(fontSize: 11,
                       fontFamily: AppStrings.fontNormal,
                       color: AppColors.kTextColor),),
                  YMargin(8),
                  Text("\$5,000,000", style: TextStyle(fontSize: 11,
                      fontFamily: AppStrings.fontMedium,
                      color: AppColors.kTextColor),),
              ],),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Text("Balance", style: TextStyle(fontSize: 11,
                       fontFamily: AppStrings.fontNormal,
                       color: AppColors.kTextColor),),
                  YMargin(8),
                  Text("10%", style: TextStyle(fontSize: 11,
                      fontFamily: AppStrings.fontMedium,
                      color: AppColors.kWealthDark),),
              ],)
            ],),
            YMargin(8)
          ],
        ),
      ),
    );
  }
}

class EmptyInvstmentWidget extends StatelessWidget {
  const EmptyInvstmentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      YMargin(MediaQuery.of(context).size.height > 700 ? 100 : 50),
      SvgPicture.asset("images/new/empty3.svg",),
      YMargin(20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 200,
              child: Text(
                "You currently don’t have an Investment plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kGreyText,
                    height: 1.6),
              )),
        ],
      ),
      YMargin(40),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButtonNew(
            onTap: (){},
            title: "Start Investing",
          ),
        ],
      ),
    ],);
  }
}
