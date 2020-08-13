import 'package:flutter/material.dart';
import 'package:zimvest/data/models/investment/bank_payment_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class BankTransferModalBottomSheet extends StatelessWidget {
  final BankPaymentDetails details;
  const BankTransferModalBottomSheet({
    Key key, this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      color: AppColors.kLightBG,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                YMargin(5),
                Container(
                  height: 5,
                  width: 92,
                  decoration: BoxDecoration(
                      color: AppColors.kLightText,
                      borderRadius: BorderRadius.circular(4)
                  ),
                ),
                YMargin(22),
                Text("Bank Transfer", style: TextStyle(color: AppColors.kPrimaryColor,
                    fontFamily: "Caros-Bold",fontSize: 16),),
                YMargin(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'To complete this payment, '
                              'kindly Select any of the bank accounts '
                              'listed below that you want to transfer the '
                              'sum of ',
                              style: TextStyle(color: AppColors.kPrimaryColor,
                                  fontSize: 12, height: 1.85)),
                          TextSpan(text: details.transactionAmount,
                              style: TextStyle(color: AppColors.kPrimaryColor,
                                  fontSize: 12, height: 1.85, fontFamily: "Caros-Bold")),
                          TextSpan(text: ' to, Include your unique ',
                              style: TextStyle(color: AppColors.kPrimaryColor,
                                  fontSize: 12, height: 1.85)),
                          TextSpan(text: 'Reference Number',
                              style: TextStyle(color: AppColors.kPrimaryColor,
                                  fontSize: 12, height: 1.85, fontFamily: "Caros-Bold")),
                          TextSpan(text: '  below, your payment won’t be confirmed without the ',
                              style: TextStyle(color: AppColors.kPrimaryColor,
                                fontSize: 12, height: 1.85,)),
                          TextSpan(text: 'Reference Number',
                              style: TextStyle(color: AppColors.kPrimaryColor,
                                  fontSize: 12, height: 1.85,fontFamily: "Caros-Bold")),
                        ]
                    ),
                  ),
                ),
                YMargin(16),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 82,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Make your Bank transfer using your Reference Number",
                        style: TextStyle(color: AppColors.kLightText,fontSize: 10),),
                      Text(details.paymentReference,
                        style: TextStyle(color: AppColors.kAccentColor,
                            fontSize: 22, fontFamily: "Caros-Bold"),),

                    ],),
                ),
                YMargin(15),
                for(var i in details.paymentBanks)
                  AccountDetails(bank: i.bankName,
                    accountName: i.accountName,
                    accountNumber: i.accountNumer,
                  ),


                YMargin(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        onPressed:(){},
                        child: Row(
                          children: [
                            Icon(Icons.file_download),
                            Text("Download account details", style: TextStyle(fontSize: 10),)
                          ],
                        ),
                      ),
                    ),
                    XMargin(15),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        title: "Continue",
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                        },
                      ),
                    )
                  ],),
                ),
                YMargin(40),
              ],),
          ),
        ),
      ),
    );
  }
}

class AccountDetails extends StatelessWidget {
  final String bank;
  final String accountName;
  final String accountNumber;
  const AccountDetails({
    Key key, this.bank, this.accountName, this.accountNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: AppColors.kLightText,
      ),
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(bank, style: TextStyle(
                  fontSize: 14, fontFamily: "Caros-Medium", color: AppColors.kPrimaryColor),)
            ],),
          Spacer(),
          Text("Account name:", style: TextStyle(
              fontSize: 12, color: AppColors.kPrimaryColor2),),
          YMargin(5),
          Text(accountName, style: TextStyle(
              fontSize: 10, color: AppColors.kAccountTextColor),),
          YMargin(15),
          Text("Account number:", style: TextStyle(
              fontSize: 12, color: AppColors.kPrimaryColor2),),
          YMargin(5),
          Text(accountNumber, style: TextStyle(
              fontSize: 10, color: AppColors.kAccountTextColor),)
        ],),
    );
  }
}
