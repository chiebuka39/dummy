import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

import '../../../tabs.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0, top: 20),
        child: InkWell(
          onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabsContainer()),
              (Route<dynamic> route) => false),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: 11,
              fontFamily: AppStrings.fontNormal,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ],
    backgroundColor: Colors.transparent,
    title: Text(
      "Invest",
      style: TextStyle(
        fontSize: 13,
        fontFamily: AppStrings.fontMedium,
        color: AppColors.kTextColor,
      ),
    ),
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.kPrimaryColor,
      ),
      onPressed: () => Navigator.pop(context),
    ),
  );
}
