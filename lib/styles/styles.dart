import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';

class AppStyles{
  static TextStyle menuFlatStyle = TextStyle(
      fontSize: 12,
      color: AppColors.kLightTitleText
  );
  static TextStyle tinyTitle = TextStyle(
      color: AppColors.kLightText, fontSize: 10, letterSpacing: -0.08);

  static BorderSide menuBorder = BorderSide(color: Color(0xFF324d53),width: 0.3);
}