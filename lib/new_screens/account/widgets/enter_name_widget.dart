import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterNameWidget extends StatelessWidget {
  const EnterNameWidget({
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
          Text("Enter Your Legal Name"),
          YMargin(30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                borderRadius: BorderRadius.circular(12)
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "First Name",
                  hintStyle: TextStyle(
                      fontSize: 14
                  )
              ),
            ),
          ),
          YMargin(30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                borderRadius: BorderRadius.circular(12)
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Last Name",
                  hintStyle: TextStyle(
                      fontSize: 14
                  )
              ),
            ),
          ),
          Spacer(),

          RoundedNextButton(
            onTap: onNext,
          ),
          YMargin(120)
        ],),
    );
  }
}