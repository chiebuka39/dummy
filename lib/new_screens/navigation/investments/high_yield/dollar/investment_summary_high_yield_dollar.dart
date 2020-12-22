import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/terms_and_conditions_box.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/wealth_more.dart';

import 'dollar_investment_confirmation.dart';

class InvestmentSummaryScreenDollar extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => InvestmentSummaryScreenDollar(),
      settings: RouteSettings(
        name: InvestmentSummaryScreenDollar().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentSummaryScreenDollarState createState() =>
      _InvestmentSummaryScreenDollarState();
}

class _InvestmentSummaryScreenDollarState
    extends State<InvestmentSummaryScreenDollar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTextColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy < 0) {
            print(details.delta.dx);
            showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) {
                  return TermsAndConditionsbox();
                },
                isScrollControlled: true);
          }
        },
        child: summarySreen(context),
      ),
    );
  }
}

Widget summarySreen(context) {
  return Stack(
    children: [
      Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Container(
          height: screenHeight(context) / 1.4,
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: AppColors.kWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(73),
                Text(
                  "Investment Summary",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: AppStrings.fontMedium,
                    color: AppColors.kTextColor,
                  ),
                ),
                YMargin(27),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: AppUtils.getBoxShaddow
                  ),
                  height: screenHeight(context) / 2.2,
                  width: screenWidth(context),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YMargin(27),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "INVESTMENT NAME (Zimvest High Yield Naira 30 Days)",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontMedium,
                              color: AppColors.kLightText5,
                            ),
                          ),
                          Text(
                            "Good vibes",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontBold,
                              color: AppColors.kTextColor,
                            ),
                          ),
                        ],
                      ),
                      YMargin(40),
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "INTEREST RATE",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kLightText5,
                                  ),
                                ),
                                Text(
                                  "6% P.A",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NEXT MATURITY DATE",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kLightText5,
                                  ),
                                ),
                                Text(
                                  "Feb 29, 2020",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      YMargin(40),
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AMOUNT",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kLightText5,
                                  ),
                                ),
                                Text(
                                  "${AppStrings.nairaSymbol}20,000,000",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PROCESSING FEE (1.5%)",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kLightText5,
                                  ),
                                ),
                                Text(
                                  "${AppStrings.nairaSymbol}30,000",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      YMargin(40),
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TOTAL",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kLightText5,
                                  ),
                                ),
                                Text(
                                  "${AppStrings.nairaSymbol}20,030,000",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 34,
        left: 50,
        right: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kWhite,
              ),
            ),
            Text(
              "Swipe up to confirm",
              style: TextStyle(
                fontSize: 13,
                fontFamily: AppStrings.fontLight,
                color: AppColors.kWhite,
              ),
            ),
          ],
        ),
      )
    ],
  );
}




class InvestmentSummaryScreenDollarWired extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => InvestmentSummaryScreenDollarWired(),
      settings: RouteSettings(
        name: InvestmentSummaryScreenDollarWired().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentSummaryScreenDollarWiredState createState() =>
      _InvestmentSummaryScreenDollarWiredState();
}

class _InvestmentSummaryScreenDollarWiredState
    extends State<InvestmentSummaryScreenDollarWired> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTextColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy < 0) {
            Navigator.push(context, InvestmentConfirmationDollarWired.route());
          }
        },
        child: summarySreen(context),
      ),
    );
  }
}

