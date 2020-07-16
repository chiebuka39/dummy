import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';

class SecondaryActivityWidget extends StatelessWidget {
  final Color bg;
  const SecondaryActivityWidget({
    Key key,
    this.bg = AppColors.kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 160,
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(20),
                SizedBox(
                  width: 200,
                  child: Text(
                    "Have you taken your IPS test lately? "
                        "You need to assess your risk profile as an investor",
                    style: TextStyle(
                        color: Colors.white, fontSize: 13, height: 1.3),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "Take test now",
                      style: TextStyle(
                          color: AppColors.kAccentColor,
                          fontFamily: "Caro-Medium",
                          fontSize: 13),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.kAccentColor,
                    )
                  ],
                )
              ],
            ),
          ),
          Image.asset("images/test.png")
        ],
      ),
    );
  }
}
