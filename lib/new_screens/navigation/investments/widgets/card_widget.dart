import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class InvestmentCardNaira extends StatelessWidget {
  final String investmentDuration;
  final String percentage;
  final String minimumAmount;
  final String maximumAmount;
  final double height;
  final double width;
  const InvestmentCardNaira({
    Key key,
    @required this.investmentDuration,
    @required this.percentage,
    @required this.minimumAmount,
    @required this.maximumAmount,
    this.height = 3,
    this.width = 1.3,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: AppUtils.getBoxShaddow,
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Zimvest High Yield Naira $investmentDuration",
              style: TextStyle(fontSize: 11, fontFamily: AppStrings.fontBold),
            ),
            YMargin(8),
            Text(
              "$percentage P.A",
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.kWealthDark,
                  fontFamily: AppStrings.fontMedium),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "${AppStrings.nairaSymbol}$minimumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Maximum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "Above ${AppStrings.nairaSymbol}$maximumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                )
              ],
            ),
            YMargin(8)
          ],
        ),
      ),
    );
  }
}

class InvestmentCardDollar extends StatelessWidget {
  final String investmentDuration;
  final String percentage;
  final String minimumAmount;
  final String maximumAmount;
  final double height;
  final double width;

  const InvestmentCardDollar({
    Key key,
    @required this.investmentDuration,
    @required this.percentage,
    @required this.minimumAmount,
    @required this.maximumAmount,
    this.height = 3.5,
    this.width = 1.3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / height,
        width: MediaQuery.of(context).size.width / width,
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: AppUtils.getBoxShaddow,
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Zimvest High Yield Dollar $investmentDuration",
              style: TextStyle(fontSize: 11, fontFamily: AppStrings.fontBold),
            ),
            YMargin(8),
            Text(
              "$percentage P.A",
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.kWealthDark,
                  fontFamily: AppStrings.fontMedium),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "$minimumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Maximum Amount",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "Above $maximumAmount.00",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                  ],
                )
              ],
            ),
            YMargin(8)
          ],
        ),
      ),
    );
  }
}

class FixedIncomeCard extends StatelessWidget {
  final String bondName;
  final double rate;
  final num minimumAmount;
  final String maturityDate;

  const FixedIncomeCard(
      {Key key,
      @required this.bondName,
      @required this.rate,
      @required this.minimumAmount,
      @required this.maturityDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(11),
        margin: EdgeInsets.only(top: 25),
        height: screenHeight(context) / 5,
        width: screenWidth(context) / 1.5,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: AppUtils.getBoxShaddow,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bondName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kTextColor,
                  ),
                ),
                Text(
                  "${rate.toString()} %PA",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kFixed,
                  ),
                )
              ],
            ),
            YMargin(46),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Amount",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    ),
                    Text(
                     "${AppStrings.nairaSymbol} ${minimumAmount.toString()}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Maturity  Date",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    ),
                    Text(
                      "${maturityDate.toString()}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
