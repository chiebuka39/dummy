import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/new_screens/funding/top_up_screen.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/wealth_activites.dart';
import 'package:zimvest/widgets/navigation/wealth_more.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class InvestmentDetailsScreen extends StatefulWidget {
  final String investmentName;
  final String investmentType;
  final String balance;
  final String annualReturns;

  const InvestmentDetailsScreen(
      {Key key,
      this.investmentName,
      this.investmentType,
      this.balance,
      this.annualReturns})
      : super(key: key);
  static Route<dynamic> route(
      {String investmentName,
      String investmentType,
      String balance,
      String annualReturns}) {
    return MaterialPageRoute(
        builder: (_) => InvestmentDetailsScreen(
              investmentName: investmentName,
              investmentType: investmentType,
              balance: balance,
              annualReturns: annualReturns,
            ),
        settings:
            RouteSettings(name: InvestmentDetailsScreen().toStringShort()));
  }

  @override
  _InvestmentDetailsScreenState createState() =>
      _InvestmentDetailsScreenState();
}

class _InvestmentDetailsScreenState extends State<InvestmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  XMargin(20),
                  Text(
                    "${widget.investmentName}",
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppStrings.fontBold),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.kPrimaryColor,
                    ),
                    onPressed: () {
                      showModalBottomSheet<Null>(
                          context: context,
                          builder: (BuildContext context) {
                            return WealthMore();
                          },
                          isScrollControlled: true);
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: [
                    Text(
                      "You invested in ${widget.investmentType}",
                      style: TextStyle(
                          fontSize: 11,
                          color: AppColors.kPrimaryColor,
                          fontFamily: AppStrings.fontMedium),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: AppColors.kPrimaryColor,
                    )
                  ],
                ),
              ),
              YMargin(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kSecondaryText),
                    ),
                    YMargin(10),
                    Text(
                      widget.balance,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(25),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Accrued Interest",
                              style: TextStyle(
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kGreyText,
                                  fontSize: 11),
                            ),
                            YMargin(4),
                            Transform.translate(
                              offset: Offset(-8, 0),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_drop_up_outlined),
                                  Text(
                                    "${AppStrings.nairaSymbol}2,000",
                                    style: TextStyle(
                                        fontFamily: AppStrings.fontMedium,
                                        color: AppColors.kWealthDark,
                                        fontSize: 11),
                                  ),
                                  XMargin(5),
                                  Text(
                                    "Past 24h",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppStrings.fontNormal),
                                  ),
                                ],
                              ),
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
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kGreyText,
                                  fontSize: 11),
                            ),
                            YMargin(4),
                            Text(
                              "${widget.annualReturns}",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: AppStrings.fontMedium,
                                  color: AppColors.kWealthDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              YMargin(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(WithdrawWealthScreen.route());
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColorLight,
                                shape: BoxShape.circle),
                            child: Center(
                              child: SvgPicture.asset(
                                "images/new/withdraw1.svg",
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                          ),
                          YMargin(12),
                          Text(
                            "Liquidate",
                            style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 12,
                                fontFamily: AppStrings.fontNormal),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              YMargin(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Activities",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kGreyText),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<Null>(
                            context: context,
                            builder: (BuildContext context) {
                              return WealthBoxActivities();
                            },
                            isScrollControlled: true);
                      },
                      child: Text("See all",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontMedium,
                              color: AppColors.kPrimaryColor)),
                    )
                  ],
                ),
              ),
              ...List.generate(4, (index) {
                return WealthBoxActivity(
                  productTransaction: ProductTransaction(
                      id: 9,
                      dateCreated: DateTime.now(),
                      dateUpdated: DateTime.now(),
                      status: 2,
                      statusText: "Paid",
                      amount: 30000,
                      transactionDescription: "Funding from wallet"),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
