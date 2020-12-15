import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/dollar_investment_confirmation.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class TermsAndConditionsbox extends StatelessWidget {
  const TermsAndConditionsbox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery.of(context).size.width - 110) / 2;
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          YMargin(10),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          YMargin(20),
          Expanded(
              child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(20),
                Text(
                  "Terms & Conditions",
                  style:
                      TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
                ),
                YMargin(25),
                Text(
                  "I agree that Interest on this investment is subject to 10% withholding tax.  Liquidating this investment before maturity will attract a 15% charge on the accrued interest.",
                  style: TextStyle(
                      fontSize: 11, height: 1.6, color: AppColors.kGreyText),
                ),
                YMargin(24),
                Row(
                  children: [
                    PrimaryButtonNew(
                      textColor: AppColors.kPrimaryColor,
                      bg: AppColors.kPrimaryColorLight,
                      width: buttonWidth,
                      title: "No",
                    ),
                    XMargin(
                      20,
                    ),
                    PrimaryButtonNew(
                      textColor: AppColors.kWhite,
                      bg: AppColors.kPrimaryColor,
                      width: buttonWidth,
                      title: "Yes",
                      onTap: (){Navigator.push(context, InvestmentConfirmationDollar.route());},
                    )
                  ],
                )
              ],
            ),
          )),
          YMargin(30)
        ],
      ),
    );
  }
}
