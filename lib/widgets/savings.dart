
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';

class SavingsActionWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String icon;
  const SavingsActionWidget({
    Key key,
    this.title,
    this.onTap,
    this.icon = "savings",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              "images/$icon.svg",
              color: AppColors.kAccentColor,
            ),
            Text(
              title,
              style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 11,
                  fontFamily: "Caros-medium"),
            )
          ],
        ),
      ),
    );
  }
}

class SavingsDetailContainer extends StatelessWidget {
  final SavingPlanModel savingPlanModel;
  const SavingsDetailContainer({
    Key key,
    @required this.savingPlanModel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
   var amount = FlutterMoneyFormatter(
        amount: savingPlanModel.targetAmount, settings: MoneyFormatterSettings(fractionDigits: 0,symbol: "\u20A6"));

    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    savingPlanModel.planName,
                    style: TextStyle(fontSize: 13, color: Color(0xFFa2bdc3)),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 115,
                    child: Text(
                      "Joined ${savingPlanModel.dateCreated.day} March, ${savingPlanModel.dateCreated.year}",
                      style: TextStyle(fontSize: 10, color: Color(0xFFa2bdc3)),
                    ),
                  ),
                ],
              ),
              YMargin(4),
              Text(
                amount.output.symbolOnLeft,
                style: TextStyle(
                    color: AppColors.kWhite,
                    fontSize: 17,
                    fontFamily: "Caros-Medium"),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Accrued Interest",
                    style: TextStyle(
                        fontSize: 10, color: AppColors.kLightTitleText),
                  ),
                  YMargin(3),
                  Text(
                    amount.output.symbolOnLeft,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Caros-Medium",
                        color: AppColors.kWhite),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Interest rate",
                  style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 10,
                      fontFamily: "Caros-Medium"),
                ),
              ),
              XMargin(5),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "${savingPlanModel.accruedInterest}% P.A",
                  style: TextStyle(
                      color: AppColors.kLightTitleText,
                      fontSize: 12,
                      fontFamily: "Caros"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
class SavingsAspireContainer extends StatelessWidget {
  final SavingPlanModel savingPlanModel;
  const SavingsAspireContainer({
    Key key,
    @required this.savingPlanModel,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
   var amount = FlutterMoneyFormatter(
        amount: savingPlanModel.targetAmount, settings: MoneyFormatterSettings(fractionDigits: 0,symbol: "\u20A6"));

    return Container(
      height: 140,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width  - 60,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                savingPlanModel.planName,
                style: TextStyle(fontSize: 13, color: Color(0xFFa2bdc3)),
              ),
              Spacer(),
              SizedBox(
                width: 115,
                child: Text(
                  "Joined ${savingPlanModel.dateCreated.day} March, ${savingPlanModel.dateCreated.year}",
                  style: TextStyle(fontSize: 10, color: Color(0xFFa2bdc3)),
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "Accrued Interest",
            style: TextStyle(
                fontSize: 10, color: AppColors.kLightTitleText),
          ),
          YMargin(5),
          Row(
            children: [
              Text(
                amount.output.symbolOnLeft,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Caros-Medium",
                    color: AppColors.kWhite),
              ),
              Spacer(),
              Text(
                "90 days average yield:",
                style: TextStyle(
                    color: AppColors.kWhite,
                    fontSize: 10,
                    fontFamily: "Caros-Medium"),
              ),
              XMargin(5),
              Text(
                "${savingPlanModel.accruedInterest}%",
                style: TextStyle(
                    color: AppColors.kLightTitleText,
                    fontSize: 12,
                    fontFamily: "Caros"),
              ),
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

