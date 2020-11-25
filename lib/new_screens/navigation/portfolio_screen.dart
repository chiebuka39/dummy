import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
                    Container(
                      width: 115,
                      height: 28,
                      decoration: BoxDecoration(
                          color: AppColors.kGrey,
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("images/gift.svg"),
                          XMargin(6),
                          Text(
                            "Earn Free Cash",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontNormal),
                          )
                        ],
                      ),
                    )
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
                        color: AppColors.kGrey,
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
                                color: AppColors.kGreyText,
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
                                          : AppColors.kGreyText),
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
                                          : AppColors.kGreyText),
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
                : SavingsInvestmentCashWidget(),
          ],
        ),
      ),
    );
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
        YMargin(MediaQuery.of(context).size.height > 700 ? 350 : 250),
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

class SavingsInvestmentCashWidget extends StatelessWidget {
  const SavingsInvestmentCashWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          amount: 100000,
        ),
        YMargin(25),
        Container(
          height: 154,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.kGreyBg,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(3),
              Text("Zimvest WealthBox"),
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
                        "${AppStrings.nairaSymbol}500,000",
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
                        "5.5%",
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
        YMargin(30),
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
        ...List.generate((6 / 2).round(), (index) {
          print("ppmm ${index} >>>> ${(6 / 2).round() - 1}");
          if (6.isOdd && ((6 / 2).round() - 1) == index) {
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
          if (6.isEven && ((6 / 2).round() - 1) == index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  buildAspireContainer(),
                  XMargin(20),
                  buildNewGoal(),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                buildAspireContainer(),
                XMargin(20),
                buildAspireContainer(),
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

class AspireContainerWidget extends StatelessWidget {
  const AspireContainerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          showCupertinoModalBottomSheet(context: context, builder: (context,scroll){
            return WealthBoxDetailsWidget();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 154,
          decoration: BoxDecoration(
              color: AppColors.kGreyBg, borderRadius: BorderRadius.circular(13)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rent",
                style: TextStyle(
                    fontFamily: AppStrings.fontMedium,
                    color: AppColors.kGreyText),
              ),
              Spacer(),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kGreyText),
                      ),
                      YMargin(8),
                      Text(
                        "${AppStrings.nairaSymbol}500,000",
                        style: TextStyle(
                            fontFamily: AppStrings.fontMedium, fontSize: 12),
                      )
                    ],
                  ),
                  Spacer(),
                  CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 3.0,
                    animation: true,
                    percent: 0.7,
                    center: new Text(
                      "7%",
                      style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 7),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.kPrimaryColor,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



class AspireNewGoalWidget extends StatelessWidget {
  const AspireNewGoalWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 154,
        decoration: BoxDecoration(
            color: AppColors.kGreyBg, borderRadius: BorderRadius.circular(13)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset("images/new/Addd.svg"),
            Text(
              "Create New Goal",
              style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontMedium),
            )
          ],
        ),
      ),
    );
  }
}

class MoneyTitleWidget extends StatelessWidget {
  const MoneyTitleWidget({
    Key key,
    this.amount,
  }) : super(key: key);

  final double amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.translate(
            offset: Offset(0, -4),
            child: Text(
              AppStrings.nairaSymbol,
              style: TextStyle(fontSize: 14),
            )),
        XMargin(2),
        Text(
          FlutterMoneyFormatter(amount: amount).output.withoutFractionDigits,
          style: TextStyle(fontSize: 25, fontFamily: AppStrings.fontMedium),
        ),
        XMargin(3),
        Transform.translate(
          offset: Offset(0, -4),
          child: Text(
            ".00",
            style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium),
          ),
        ),
      ],
    );
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
                height: 60,
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
                            child: Text("Naira")),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                naira = false;
                              });
                            },
                            child: Text("Dollar")),
                      ],
                    ),
                    AnimatedPositioned(
                        top: 25,
                        left: naira ? 5 : 62,
                        child: Container(
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(color: AppColors.kGreyText),
                        ),
                        duration: Duration(milliseconds: 300))
                  ],
                ),
              )
            ],
          ),
          YMargin(MediaQuery.of(context).size.height > 700 ? 300 : 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 200,
                  child: Text(
                    "You currently don’t have a Investing plan",
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
        ]),
      ),
    );
  }
}
