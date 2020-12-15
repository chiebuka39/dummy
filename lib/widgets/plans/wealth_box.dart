import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:zimvest/data/models/investment/investment_fixed_fund.dart';
import 'package:zimvest/screens/tabs/invstment/investment_details_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/enums.dart';
import 'package:zimvest/utils/margin.dart';

class WealthBoxContainer extends StatelessWidget {
  const WealthBoxContainer({
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: EdgeInsets.only(left: 20,right: 20,top: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Center(
                    child: Text(
                      "Balance",
                      style: TextStyle(
                          fontSize: 10,
                          color: AppColors.kLightText4,
                          fontFamily: "Caros"),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "8% Interest P.A",
                      style: TextStyle(
                          color: AppColors.kWhite,
                          fontSize: 10,
                          fontFamily: "Caros-Medium"),
                    ),
                  )

                ],
              ),


              Text(
                "\u20A6 10,000,000",
                style: TextStyle(
                    color: AppColors.kLightText,
                    fontSize: 18,
                    fontFamily: "Caros-Bold"),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                child: Row(children: [
                  Text("View details",style: TextStyle(
                      color: AppColors.kAccentColor,
                      fontSize: 10,
                    fontFamily: "Caros-Medium"
                  ),),
                  Icon(Icons.navigate_next, color: AppColors.kAccentColor,size: 18,)
                ],),
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
                    "Accrued interest",
                    style: TextStyle(
                        fontSize: 10, color: AppColors.kLightTitleText),
                  ),
                  YMargin(3),
                  Text(
                    "\u20A6 10,000,000",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Caros-Medium",
                        color: AppColors.kWhite),
                  )
                ],
              ),
              Spacer(),

            ],
          )
        ],
      ),
    );
  }

}