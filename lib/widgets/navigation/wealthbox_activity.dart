import 'package:flutter/material.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/transactions_portfolio/investment_activities.dart';
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          Row(children: [
            Text(AppStrings.nairaSymbol,style: TextStyle(fontSize: 12,)),
            Text("${productTransaction.amount}".split(".").first.convertWithComma(),
              style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),)
          ],),
          YMargin(5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                  color: productTransaction.status == 3
                      ?AppColors.kGreen.withOpacity(0.1)
                      :AppColors.kRed.withOpacity(0.1), borderRadius: BorderRadius.circular(7)),
              child: Text(productTransaction.status == 3? "Successful":'Failed',style: TextStyle(color:productTransaction.status == 3?AppColors.kGreen:AppColors.kRed,fontSize: 10),))
        ],)

      ],),
    );
  }
}

class InvestmentActivity extends StatelessWidget {
  const InvestmentActivity({
    Key key,
    this.productTransaction,
  }) : super(key: key);

  final TransactionData productTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productTransaction.description.length > 50
                    ? productTransaction.description.substring(0, 50)
                    : productTransaction.description,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kGreyText),
              ),
              YMargin(10),
              Text(
                productTransaction.date,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kGreyText),
              )
            ],
          ),
          Spacer(),
          Text(
            "${productTransaction.amount}",
            style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),
          )
        ],
      ),
    );
  }
}
