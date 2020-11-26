import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class DeleteWealthbox extends StatelessWidget {
  const DeleteWealthbox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery
        .of(context)
        .size
        .width - 110) / 2;
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(20),
              Text("Delete Zimvest Wealthbox plan", style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold
              ),),
              YMargin(25),
              Text("Are you sure you want to delete this savings plan, your funds "
                  "would be deposited in your wallet",
                style: TextStyle(fontSize: 11,height: 1.6,color: AppColors.kGreyText),
              ),
              YMargin(45),
              Row(children: [
                PrimaryButtonNew(
                  width: buttonWidth,
                  title: "Yes",
                ),
                XMargin(20,),
                PrimaryButtonNew(
                  textColor: AppColors.kGreyText,
                  bg: AppColors.kGreyBg,
                  width: buttonWidth,
                  title: "No",
                )
              ],)


            ],),
        )),
        YMargin(30)
      ],),
    );
  }
}