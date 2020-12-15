import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

import '../../../../tabs.dart';

class InvestmentConfirmationDollar extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => InvestmentConfirmationDollar(),
      settings: RouteSettings(
        name: InvestmentConfirmationDollar().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentConfirmationDollarState createState() =>
      _InvestmentConfirmationDollarState();
}

class _InvestmentConfirmationDollarState
    extends State<InvestmentConfirmationDollar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTextColor,
      body: Stack(
        children: [
          // Positioned(child: SvgPicture.asset("circle_shades.svg", color: AppColors.kWhite,),),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Processing",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kWhite,
                  ),
                ),
                YMargin(42),
                SvgPicture.asset("images/confetti.svg"),
                YMargin(42),
                Text(
                  "Transaction will be confirmed between \n48 - 72 hours",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kWhite,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: screenWidth(context) / 4,
            right: screenWidth(context) / 4,
            bottom: screenHeight(context) / 14,
            child: PrimaryButtonNew(
              title: "Done",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context, TabsContainer.route(), (route) => false);
              },
              height: screenHeight(context) / 12.8,
              width: screenWidth(context) / 2,
            ),
          )
        ],
      ),
    );
  }
}

class InvestmentConfirmationDollarWired extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => InvestmentConfirmationDollarWired(),
      settings: RouteSettings(
        name: InvestmentConfirmationDollarWired().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentConfirmationDollarWiredState createState() =>
      _InvestmentConfirmationDollarWiredState();
}

class _InvestmentConfirmationDollarWiredState
    extends State<InvestmentConfirmationDollarWired> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTextColor,
      body: Stack(
        children: [
          // Positioned(child: SvgPicture.asset("circle_shades.svg", color: AppColors.kWhite,),),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Awaiting Confirmation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kWhite,
                  ),
                ),
                YMargin(42),
                SvgPicture.asset("images/confetti.svg"),
                YMargin(42),
                Text(
                  "Transaction will be confirmed between \n48 - 72 hours",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kWhite,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: screenWidth(context) / 4,
            right: screenWidth(context) / 4,
            bottom: screenHeight(context) / 14,
            child: PrimaryButtonNew(
              title: "Done",
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context, TabsContainer.route(), (route) => false);
              },
              height: screenHeight(context) / 12.8,
              width: screenWidth(context) / 2,
            ),
          )
        ],
      ),
    );
  }
}
