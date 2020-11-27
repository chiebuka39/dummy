import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class WealthBoxActivity extends StatelessWidget {
  const WealthBoxActivity({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Interest paid", style: TextStyle(
                fontSize: 12,
                fontFamily: AppStrings.fontNormal,
                color: AppColors.kGreyText
            ),),
            YMargin(10),
            Text("3rd May 2020", style: TextStyle(
                fontSize: 10,
                fontFamily: AppStrings.fontNormal,
                color: AppColors.kGreyText
            ),)
          ],),
        Spacer(),
        Text("${AppStrings.nairaSymbol}15.06", style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),)
      ],),
    );
  }
}