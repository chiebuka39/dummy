import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/profile/earn_free_cash_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class EarnFreeCashWidget extends StatelessWidget {
  const EarnFreeCashWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(EarnFreeCashScreen.route());
      },
      child: Container(
        width: 115,
        height: 28,
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColorLight,
            borderRadius: BorderRadius.circular(14)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/new/gift.svg"),
            XMargin(6),
            Text(
              "Earn Free Cash",
              style: TextStyle(
                  fontSize: 10,color: AppColors.kPrimaryColor,
                  fontFamily: AppStrings.fontMedium),
            )
          ],
        ),
      ),
    );
  }
}