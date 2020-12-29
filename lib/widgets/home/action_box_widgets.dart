import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ActionBoxWidget extends StatelessWidget {
  const ActionBoxWidget({
    Key key,
    @required this.title,
    @required this.desc,
    this.img,
    this.color = AppColors.kGrey,
    this.textColor = AppColors.kWhite,
    this.onTap,
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
    print(double.infinity);
    // MediaQuery.of(context).size.height / 15.75,
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 4.6,
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        width: MediaQuery.of(context).size.height / 2.25671641791,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                      fontFamily: AppStrings.fontMedium),
                ),
                YMargin(10),
                Container(
                  height: MediaQuery.of(context).size.height / 15.75,
                  width: MediaQuery.of(context).size.height / 5.81538461538,
                  child: Text(
                    desc,
                    style:
                        TextStyle(fontSize: 10, color: textColor, height: 1.6),
                  ),
                )
              ],
            ),
            // Spacer(),
            Container(
              height: MediaQuery.of(context).size.height / 4.90909090909,
              width: MediaQuery.of(context).size.height / 5.21379310345,
              child: SvgPicture.asset("images/new/$pic.svg",
                  height: MediaQuery.of(context).size.height / 4.90909090909,
                  width: MediaQuery.of(context).size.height / 5.21379310345),
            )
          ],
        ),
      ),
    );
  }
}
