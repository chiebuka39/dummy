import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class ChooseGenderWidget extends StatelessWidget {
  const ChooseGenderWidget({
    Key key, this.onNext,
  }) : super(key: key);
  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(50),
          Text("Choose Your Gender"),
          YMargin(30),
          Row(children: [
            Container(
              width: 135,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: AppColors.kLightText
              ),
              child: Center(child: Column(

                children: [
                  Spacer(flex: 2,),
                Text("🤵🏽",style: TextStyle(fontSize: 40),),
                YMargin(5),
                Text("Male"),
                  Spacer(flex: 3,),
              ],),),
            ),
            Spacer(),
            Container(
              width: 135,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: AppColors.kLightText
              ),
              child: Center(child: Column(

                children: [
                  Spacer(flex: 2,),
                Text("👩🏽‍💼",style: TextStyle(fontSize: 40),),
                YMargin(5),
                Text("Male"),
                  Spacer(flex: 3,),
              ],),),
            ),
          ],),
          Spacer(),
          RoundedNextButton(
            onTap: onNext,
          ),
          YMargin(120)
        ],),
    );
  }
}