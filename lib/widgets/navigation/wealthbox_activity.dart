import 'package:flutter/material.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class WealthBoxActivity extends StatelessWidget {
  const WealthBoxActivity({
    Key key, this.productTransaction,
  }) : super(key: key);

  final ProductTransaction productTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productTransaction.transactionDescription.length > 50 ? productTransaction.transactionDescription.substring(0,50):productTransaction.transactionDescription, style: TextStyle(
                fontSize: 12,
                fontFamily: AppStrings.fontNormal,
                color: AppColors.kGreyText
            ),),
            YMargin(10),
            Text(AppUtils.getReadableDateShort(productTransaction.dateUpdated), style: TextStyle(
                fontSize: 10,
                fontFamily: AppStrings.fontNormal,
                color: AppColors.kGreyText
            ),)
          ],),
        Spacer(),
        Text(AppStrings.nairaSymbol,style: TextStyle(fontSize: 12,)),
        Text("${productTransaction.amount}".split(".").first.convertWithComma(), style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),)
      ],),
    );
  }
}