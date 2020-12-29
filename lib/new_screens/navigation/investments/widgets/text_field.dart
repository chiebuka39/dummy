import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class InvestmentTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String initalValue;
  final bool readOnly;
  final bool showCursor;
  const InvestmentTextField(
      {Key key,
      @required this.controller,
      @required this.hintText,
      this.initalValue, this.readOnly = true, this.showCursor = true})
      : super(key: key);
  @override
  _InvestmentTextFieldState createState() => _InvestmentTextFieldState();
}

class _InvestmentTextFieldState extends State<InvestmentTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kTextBg,
        ),
        height: screenHeight(context) / 12.5,
        child: Center(
          child: TextFormField(
            showCursor: widget.showCursor,
            readOnly: widget.readOnly,
            initialValue: widget.initalValue,
            controller: widget.controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 13,
                fontFamily: AppStrings.fontLight,
                color: AppColors.kLightTitleText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InvestmentTextFieldDollar extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String initalValue;

  const InvestmentTextFieldDollar(
      {Key key,
      @required this.controller,
      @required this.hintText,
      this.initalValue})
      : super(key: key);
  @override
  _InvestmentTextFieldDollarState createState() =>
      _InvestmentTextFieldDollarState();
}

class _InvestmentTextFieldDollarState extends State<InvestmentTextFieldDollar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.only(left: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kTextBg,
        ),
        height: screenHeight(context) / 12.5,
        child: Center(
          child: TextFormField(
            showCursor: false,
            readOnly: true,
            initialValue: widget.initalValue,
            controller: widget.controller,
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 13,
                fontFamily: AppStrings.fontLight,
                color: AppColors.kLightTitleText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
