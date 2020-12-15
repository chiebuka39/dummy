import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class InvestmentConfirmationNaira extends StatefulWidget {
  @override
  _InvestmentConfirmationNairaState createState() =>
      _InvestmentConfirmationNairaState();
}

class _InvestmentConfirmationNairaState
    extends State<InvestmentConfirmationNaira> {
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
                SvgPicture.asset("images/confetti.svg"),
                YMargin(42),
                Text(
                  "You Have Successfully Invested In \n Zimvest High Yield Naira",
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
            left:screenWidth(context)/4,
            right:  screenWidth(context)/4,
            bottom: screenHeight(context) / 14,
            child: PrimaryButtonNew(
              title: "Done",
              onTap: () {Navigator.pushAndRemoveUntil(context, TabsContainer.route(), (route) => false);},
              height: screenHeight(context) / 12.8,
              width: screenWidth(context) / 2,
            ),
          )
        ],
      ),
    );
  }
}
