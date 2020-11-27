import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/wealth/investment_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({
    Key key, this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, InvestmentDetailsScreen.route());
      },
      child: Container(
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 7),

        width: double.infinity,
        decoration: BoxDecoration(
        ),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColorLight,
                  shape: BoxShape.circle),
              child: Center(child: SvgPicture.asset("images/new/top_up.svg",color: AppColors.kPrimaryColor,),),
            ),
            XMargin(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rent",
                  style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontMedium),
                ),
                YMargin(8),
                Text(
                  "2nd May, 2020",
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.kTextColor,
                      fontFamily: AppStrings.fontLight),
                ),

              ],
            ),
            Spacer(),
            Text("${AppStrings.nairaSymbol}25,000", style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}