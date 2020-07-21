import 'package:flutter/material.dart';

class AppUtils{
  static List<BoxShadow> getBoxShaddow = [
    BoxShadow(
        offset: Offset(0, 1),
        color: Color(0xFF000000).withOpacity(0.05),
        blurRadius: 5)
  ];
  static List<BoxShadow> getBoxShaddow2 = [
    BoxShadow(
        offset: Offset(0, 0.05),
        color: Color(0xFF000000).withOpacity(0.03),
        blurRadius: 2)
  ];
}