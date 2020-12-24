import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/enums.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class ZimSelectedButton extends StatelessWidget {
  final VoidCallback onTap;
  final ZimType2 type;
  final ZimType2 selectedType;
  final String title;
  final double leftMargin;
  const ZimSelectedButton({
    Key key,
    this.onTap,
    this.title,
    this.type,
    this.selectedType,
    this.leftMargin = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.only(left: leftMargin),
        padding: EdgeInsets.only(left: 10, right: 10),
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

class ZimSelectedButton2 extends StatelessWidget {
  final VoidCallback onTap;
  final int type;
  final int selectedType;
  final String title;
  final double leftMargin;
  const ZimSelectedButton2({
    Key key,
    this.onTap,
    this.title,
    this.type,
    this.selectedType,
    this.leftMargin = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.only(
            left: type == selectedType ? leftMargin + 10 : leftMargin),
        padding: EdgeInsets.only(left: 10, right: 10),
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
        padding: EdgeInsets.only(left: 10, right: 10),
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
      this.loading = false,
      this.horizontalMargin = 0,
      this.textColor = AppColors.kWhite})
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                        color: textColor,
                        fontFamily: "Caros-Bold"),
                  ),
          )),
    );
  }
}

class OutlinePrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final bool loading;
  final double horizontalMargin;

  const OutlinePrimaryButton(
      {Key key,
      @required this.onPressed,
      @required this.title,
      this.color = AppColors.kWhite,
      this.loading = false,
      this.horizontalMargin = 0,
      this.textColor = AppColors.kAccentColor,
      this.borderColor = AppColors.kAccentColor})
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
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: borderColor, width: .8)),
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
                        color: textColor,
                        fontFamily: "Caros-Bold"),
                  ),
          )),
    );
  }
}

class PrimaryButtonNew extends StatelessWidget {
  const PrimaryButtonNew({
    Key key,
    this.onTap,
    this.width = 200,
    this.height = 55,
    this.title,
    this.bg = AppColors.kPrimaryColor,
    this.textColor = Colors.white,
    this.loading = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final double width;
  final Color bg;
  final Color textColor;
  final double height;
  final String title;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
        child: Center(
          //   child: Text(
          //     title,
          //     style: TextStyle(
          //         color: textColor,
          //         fontSize: 13,
          //         fontFamily: AppStrings.fontNormal),
          //   ),
          // ),
          child: Center(
            child: loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 13,
                        fontFamily: AppStrings.fontNormal),
                  ),
          ),
        ),
      ),
    );
  }
}

class RoundedNextButton extends StatelessWidget {
  const RoundedNextButton({
    Key key, this.onTap, this.loading = false,
  }) : super(key: key);
  final VoidCallback onTap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 74,
          height: 74,
          child: Stack(
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimaryColorLight
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 7,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: onTap == null ? AppColors.kPrimaryColor.withOpacity(0.5) : AppColors.kPrimaryColor
                  ),
                  child: Center(child: loading ?
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),): Icon(Icons.navigate_next,color: Colors.white,),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSourceButton extends StatefulWidget {
  final Function onTap;
  final String image;
  final String paymentsource;
  final String amount;
  final Color color;

  const PaymentSourceButton(
      {Key key,
      @required this.onTap,
      @required this.image,
      @required this.paymentsource,
      this.amount = "",
      this.color = AppColors.kPrimaryColor})
      : super(key: key);

  @override
  _PaymentSourceButtonState createState() => _PaymentSourceButtonState();
}

class _PaymentSourceButtonState extends State<PaymentSourceButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.only(left: 19.0, right: 15),
          height: screenHeight(context) / 13,
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.kWhite,
                    child: Image.asset("images/${widget.image}.png"),
                  ),
                  XMargin(10),
                  Text(
                    widget.paymentsource,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontLight,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.amount,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontLight,
                      color: AppColors.kWhite,
                    ),
                  ),
                  XMargin(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.kWhite,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSourceButtonSpecial extends StatefulWidget {
  final Function onTap;
  final String image;
  final String paymentsource;
  final String amount;
  final Color color;

  const PaymentSourceButtonSpecial(
      {Key key,
      @required this.onTap,
      this.image,
      @required this.paymentsource,
      this.amount = "",
      this.color = AppColors.kPrimaryColor})
      : super(key: key);

  @override
  _PaymentSourceButtonSpecialState createState() =>
      _PaymentSourceButtonSpecialState();
}

class _PaymentSourceButtonSpecialState
    extends State<PaymentSourceButtonSpecial> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: EdgeInsets.only(left: 19.0, right: 15),
          height: screenHeight(context) / 13,
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // CircleAvatar(
                  // backgroundColor: AppColors.kWhite,
                  // child: Image.asset("images/${widget.image}.png"),
                  // ),
                  // XMargin(10),
                  Text(
                    widget.paymentsource,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontLight,
                      color: AppColors.kWhite,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.amount,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppStrings.fontLight,
                      color: AppColors.kWhite,
                    ),
                  ),
                  XMargin(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.kWhite,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
