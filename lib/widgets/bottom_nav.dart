import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';


class BottomNavEntry extends StatelessWidget {
  // title of the nav entry
  final String title;
  // icon image
  final String image;
  // onTap functionality
  final Function onTap;
  // if the entry is selected or not
  final bool isSelected;

  BottomNavEntry({
    this.onTap,
    this.title,
    this.image,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        color: Colors.transparent,
        duration: Duration(milliseconds: 300),
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset("images/$image.svg", height: 23,color: isSelected ? AppColors.kAccentColor: AppColors.kLightText,),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.kAccentColor: AppColors.kLightText,
                fontFamily: 'Caros',
                fontSize: 10,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
