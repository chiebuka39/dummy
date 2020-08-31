import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/styles/styles.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class SectionWidgets extends StatelessWidget {
  SectionWidgets({
    Key key, this.title = "Save with Zimvest Wealth Box",
    this.content = '', this.bgColor = AppColors.kLightText, this.img = 'wealth_box',
  }) : super(key: key);

  final String title;
  final String content;
  final String img;
  final Color bgColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 15,left: 15,bottom: 0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.kAccountTextColor,width: 0.25)
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.sectionHeader,),
              YMargin(15),
              SizedBox(width: 182,child: Text(content,
                style:AppStyles.sectionContent,),)
            ],),
          Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset("images/$img.svg")
          )
        ],
      ),
    );
  }
}