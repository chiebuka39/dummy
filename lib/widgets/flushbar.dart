import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

dynamic errorFlushBar(BuildContext context, String title, String error) {
  return Flushbar(
    icon: ImageIcon(
      AssetImage("images/failed.png"),
      color: AppColors.kRed,
      size: 70,
    ),
    margin: EdgeInsets.all(12),
    borderRadius: 20,
    flushbarPosition: FlushbarPosition.TOP,
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontFamily: AppStrings.fontBold,
        color: AppColors.kRed4,
      ),
    ),
    backgroundColor: AppColors.kRed3,
    messageText: Text(
      error,
      style: TextStyle(
        fontSize: 11,
        fontFamily: AppStrings.fontLight,
        color: AppColors.kRed4,
      ),
    ),
    duration: Duration(seconds: 3),
  ).show(context);
}

dynamic cautionFlushBar(BuildContext context, String title, String message) {
  return Flushbar(
    margin: EdgeInsets.all(12),
    borderRadius: 20,
    flushbarPosition: FlushbarPosition.TOP,
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontFamily: AppStrings.fontBold,
        color: AppColors.kPrimaryColor,
      ),
    ),
    backgroundColor: AppColors.kPrimaryColorLight,
    messageText: Text(
      message,
      style: TextStyle(
        fontSize: 11,
        fontFamily: AppStrings.fontLight,
        color: AppColors.kPrimaryColor,
      ),
    ),
    duration: Duration(seconds: 3),
  ).show(context);
}
