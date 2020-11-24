import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ActionBoxWidget extends StatelessWidget {
  const ActionBoxWidget({
    Key key,@required this.title,@required this.desc, this.img,
  }) : super(key: key);

  final String title;
  final String desc;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164,
      margin: EdgeInsets.only(left: 20, right:20,top: 30),
      padding: EdgeInsets.only(left: 20, right:20,top: 30),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.kGrey,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(
                  color: AppColors.kGreyText,
                  fontSize: 15,
                  fontFamily: AppStrings.fontMedium
              ),),
              YMargin(10),
              SizedBox(
                width: 180,
                child: Text(desc, style: TextStyle(
                    fontSize: 11,
                    color: AppColors.kGreyText,height: 1.6
                ),),
              )
            ],),
        ],
      ),
    );
  }
}