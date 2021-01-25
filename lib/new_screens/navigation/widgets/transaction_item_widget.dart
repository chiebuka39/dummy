import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/new_screens/navigation/wealth/investment_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class TransactionItemWidget extends StatelessWidget {
  const TransactionItemWidget({
    Key key, this.onTap, this.narration, this.date, this.amount, this.symbol, this.topUp = true,@required this.trans,
  }) : super(key: key);

  final VoidCallback onTap;
  final String narration;
  final String date;
  final num amount;
  final String symbol;
  final bool topUp;
  final ProductTransaction trans;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, InvestmentDetailsScreen.route());
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
              child: Center(child: SvgPicture.asset("images/new/${topUp ? 'top_up':'withdraw'}.svg",color: AppColors.kPrimaryColor,),),
            ),
            XMargin(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    narration,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontMedium),
                  ),
                ),
                YMargin(8),
                Text(
                  date,
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.kTextColor,
                      fontFamily: AppStrings.fontLight),
                ),

              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(symbol,style: TextStyle(fontSize: 12)),
                    Text("$amount".split(".").first.convertWithComma(), style: TextStyle(fontSize: 12),),
                  ],
                ),
                YMargin(5),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                        color: trans.status == 3
                            ?AppColors.kGreen.withOpacity(0.1)
                            :AppColors.kRed.withOpacity(0.1), borderRadius: BorderRadius.circular(7)),
                    child: Text(trans.status == 3? "Successful":'Failed',style: TextStyle(color:trans.status == 3?AppColors.kGreen:AppColors.kRed,fontSize: 10),)),
              ],)

          ],
        ),
      ),
    );
  }
}


class TransactionItemWidgetWithdrawal extends StatelessWidget {
  const TransactionItemWidgetWithdrawal({
    Key key, this.onTap, this.narration, this.date, this.amount, this.symbol,
  }) : super(key: key);

  final VoidCallback onTap;
  final String narration;
  final String date;
  final num amount;
  final String symbol;

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
              child: Center(child: SvgPicture.asset("images/new/withdraw.svg",color: AppColors.kPrimaryColor,),),
            ),
            XMargin(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130,
                  child: Text(
                    narration ?? '',
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontMedium),
                  ),
                ),
                YMargin(8),
                Text(
                  date,
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.kTextColor,
                      fontFamily: AppStrings.fontLight),
                ),

              ],
            ),
            Spacer(),
            Row(
              children: [
                Text(symbol, style: TextStyle(fontSize: 12),),
                Text("$amount".split(".").first.convertWithComma(), style: TextStyle(fontSize: 12),),
              ],
            )
          ],
        ),
      ),
    );
  }
}