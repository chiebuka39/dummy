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
        padding: EdgeInsets.only(left: 10,right: 10),
        duration: Duration(milliseconds: 200),
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
class ZimInVestSelectedButton extends StatelessWidget {
  final VoidCallback onTap;
  final ZimInvestmentType type;
  final ZimInvestmentType selectedType;
  final String title;
  const ZimInVestSelectedButton({
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
        padding: EdgeInsets.only(left: 10,right: 10),
        duration: Duration(milliseconds: 200),
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

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  final Color textColor;
  final bool loading;
  final double horizontalMargin;

  const PrimaryButton(
      {Key key,
        @required this.onPressed,
        @required this.title,
        this.color = AppColors.kAccentColor,
        this.loading = false, this.horizontalMargin = 0, this.textColor = AppColors.kWhite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: ButtonTheme(
          minWidth: double.infinity,
          buttonColor: color,
          height: 55,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            ),
            onPressed: onPressed,
            child: loading == true
                ? SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              title,
              style: TextStyle(
                fontSize: 14,
                  color: textColor, fontFamily: "Caros-Bold"),
            ),
          )),
    );
  }
}