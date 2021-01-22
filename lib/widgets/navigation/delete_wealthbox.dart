import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class DeleteWealthbox extends StatelessWidget {
  const DeleteWealthbox({
    Key key,
    this.savingPlanModel,
  }) : super(key: key);

  final SavingPlanModel savingPlanModel;

  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    ABSIdentityViewModel identityViewModel = Provider.of(context);
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
                  "Delete Zimvest Wealthbox plan",
                  style:
                      TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
                ),
                YMargin(25),
                Text(
                  "Are you sure you want to delete this savings plan, your funds "
                  "would be deposited in your wallet",
                  style: TextStyle(
                      fontSize: 11, height: 1.6, color: AppColors.kGreyText),
                ),
                YMargin(45),
                Row(
                  children: [
                    PrimaryButtonNew(
                      width: buttonWidth,
                      title: "Yes",
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                    XMargin(
                      20,
                    ),
                    PrimaryButtonNew(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      textColor: AppColors.kGreyText,
                      bg: AppColors.kGreyBg,
                      width: buttonWidth,
                      title: "No",
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

class ConfirmSavings extends StatelessWidget {
  const ConfirmSavings({
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
                  "Confirm Wealthbox plan",
                  style:
                      TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
                ),
                YMargin(25),
                Text(
                  "I agree to forfeit 15% of my accrued interest if I "
                  "withdraw on any day aside 1st day of every quarter",
                  style: TextStyle(
                      fontSize: 11, height: 1.6, color: AppColors.kGreyText),
                ),
                YMargin(45),
                Row(
                  children: [
                    PrimaryButtonNew(
                      width: buttonWidth,
                      title: "No",
                      textColor: AppColors.kPrimaryColor,
                      bg: AppColors.kPrimaryColorLight,
                    ),
                    XMargin(
                      20,
                    ),
                    PrimaryButtonNew(
                      textColor: AppColors.kWhite,
                      bg: AppColors.kPrimaryColor,
                      width: buttonWidth,
                      onTap: () {
                        Navigator.push(context, TopUpSuccessful.route());
                      },
                      title: "Yes",
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

class ConfirmAssetLiquidation extends StatelessWidget {
  const ConfirmAssetLiquidation({
    Key key,
    this.name,
    this.withDrawable,
    this.transactionId,
    this.instrumentId,
  }) : super(key: key);
  final String name;
  final double withDrawable;
  final int transactionId;
  final int instrumentId;
  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery.of(context).size.width - 110) / 2;
    return Container(
      height: 320,
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
                  "Liquidate $name",
                  style:
                      TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
                ),
                YMargin(25),
                Text(
                  "You would be charged 15% of your accrued interest for liquidating before investment maturity,  10% WHT Applies Would you like to proceed ?",
                  style: TextStyle(
                      fontSize: 11, height: 1.6, color: AppColors.kGreyText),
                ),
                YMargin(45),
                Row(
                  children: [
                    PrimaryButtonNew(
                      textColor: AppColors.kPrimaryColor,
                      bg: AppColors.kPrimaryColorLight,
                      width: buttonWidth,
                      title: "No",
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                    XMargin(
                      20,
                    ),
                    PrimaryButtonNew(
                      onTap: () {
                        Navigator.of(context).push(
                          WithdrawWealthScreen.route(
                              name: name,
                              withDrawable: withDrawable,
                              transactionId: transactionId,
                              instrumentId: instrumentId),
                        );
                      },
                      textColor: AppColors.kWhite,
                      bg: AppColors.kPrimaryColor,
                      width: buttonWidth,
                      title: "Yes",
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
