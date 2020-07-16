import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/enums.dart';

class ZimSelectedButton extends StatelessWidget {
  final VoidCallback onTap;
  final ZimType type;
  final ZimType selectedType;
  final String title;
  const ZimSelectedButton({
    Key key,
    this.onTap,
    this.title,
    this.type,
    this.selectedType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.only(left: 10),
        duration: Duration(milliseconds: 200),
        width: 135,
        height: 35,
        decoration: BoxDecoration(
            color: type == selectedType
                ? AppColors.kAccentColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Caros-Medium",
                color: type == selectedType
                    ? AppColors.kWhite
                    : AppColors.kLightTitleText),
          ),
        ),
      ),
    );
  }
}