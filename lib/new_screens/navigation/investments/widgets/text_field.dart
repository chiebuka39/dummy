import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class InvestmentTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const InvestmentTextField({Key key, @required this.controller, @required this.hintText}) : super(key: key);
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
