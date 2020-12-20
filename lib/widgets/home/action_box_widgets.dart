import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ActionBoxWidget extends StatelessWidget {
  const ActionBoxWidget({
    Key key,@required this.title,@required this.desc, this.img,
    this.color = AppColors.kGrey, this.textColor = AppColors.kWhite, this.onTap,
  }) : super(key: key);

  final String title;
  final String desc;
  final String img;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String pic = img == null ? 'wealth1' : img;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 164,
        margin: EdgeInsets.only(left: 20, right:20,top: 30),
        padding: EdgeInsets.only(left: 20, right:20,top: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontFamily: AppStrings.fontMedium
                ),),
                YMargin(10),
                SizedBox(
                  width: 170,
                  child: Text(desc, style: TextStyle(
                      fontSize: 10,
                      color: textColor,height: 1.6
                  ),),
                )
              ],),
            Spacer(),
            SvgPicture.asset("images/new/$pic.svg", width: 120,)
          ],
        ),
      ),
    );
  }
}