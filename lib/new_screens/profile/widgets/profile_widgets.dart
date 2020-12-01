import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key, this.emergency = false, this.title, this.onClick, this.icon, this.padding = 20,
  }) : super(key: key);

  final bool emergency;
  final double padding;
  final String icon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding),
        margin: EdgeInsets.only(top: 20),
        height: 40,
        child: Row(children: [
          icon == null ? SizedBox():Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset("images/new/$icon.svg"),
          ),

          Text(title, style: TextStyle(fontSize: 13),),
          Spacer(),
          emergency ? SvgPicture.asset("images/new/emergency.svg"): SizedBox(),
          XMargin(5),
          Icon(Icons.navigate_next, color: AppColors.kPrimaryColor,)
        ],),
      ),
    );
  }
}