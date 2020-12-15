import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';

class SavingsAspireContainer2 extends StatelessWidget {
  final SavingPlanModel savingPlanModel;
  const SavingsAspireContainer2({
    Key key,
    @required this.savingPlanModel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var amount = FlutterMoneyFormatter(
        amount: savingPlanModel.targetAmount, settings: MoneyFormatterSettings(fractionDigits: 0,symbol: "\u20A6"));

    return Container(
      height: 140,

      margin: EdgeInsets.only(top: 15,left: 20,right: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                savingPlanModel.planName,
                style: TextStyle(fontSize: 16,
                    fontFamily: "Caros-Bold",
                    color: AppColors.kLightText),
              ),
              YMargin(2),
              SizedBox(
                width: 115,
                child: Text(
                  "Joined ${AppUtils.getReadableDateShort(savingPlanModel.startDate)}",
                  style: TextStyle(fontSize: 10, color: AppColors.kLightText4),
                ),
              ),
            ],
          ),
          Spacer(),

          Row(
            children: [

              Spacer(),
              Text(
                "View details",
                style: TextStyle(
                    color: AppColors.kAccentColor,
                    fontSize: 10,
                    fontFamily: "Caros-Medium"),
              ),
              Icon(Icons.navigate_next, color: AppColors.kAccentColor,)
            ],
          ),
          YMargin(5),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(1.5),
              color: AppColors.kLightText,
              child: LinearProgressIndicator(
                value: 0.6,
                backgroundColor: AppColors.kWhite,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kAccentColor),
              ),
            ),
          ),
          YMargin(15),
          Row(
            children: [
              Text(
                amount.output.symbolOnLeft,
                style: TextStyle(
                    fontSize: 9,
                    fontFamily: "Caros-Medium",
                    color: AppColors.kLightText2),
              ),
              Text(
                " / ${amount.output.symbolOnLeft}",
                style: TextStyle(
                    fontSize: 9,
                    fontFamily: "Caros-Medium",
                    color: AppColors.kWhite),
              ),
              Spacer(),
              Text(
                "25% Complete",
                style: TextStyle(
                    color: AppColors.kWhite,
                    fontSize: 10,
                    fontFamily: "Caros-Medium"),
              ),
            ],
          )
        ],
      ),
    );
  }
}