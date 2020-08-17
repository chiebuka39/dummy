import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class FundWallet extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => FundWallet(),
        settings: RouteSettings(name: FundWallet().toStringShort()));
  }
  @override
  _FundWalletState createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: ZimAppBar(
        title: "Fund Your Wallet",
        desc: 'Fill the form below to fund your wallet',
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          YMargin(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AmountWidgetBorder(
              title: "Enter Amount",
              textColor: AppColors.kAccountTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownBorderInputWidget(
              title: "Select Funding Source",
              textColor: AppColors.kAccountTextColor,
              items: [
                "Bank Transfer",
                "Debit Card"
              ],
            ),
          ),
          YMargin(20),
          Container(
            height: 128,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all( 10),
            decoration: BoxDecoration(
              color: AppColors.kLightText,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(5),
              Text("Zenith Bank", style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Caros-Bold",
                  color: AppColors.kAccountTextColor),),
              YMargin(20),
              Row(
                children: [
                  Text("Zenith Bank", style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Caros-Bold",
                      color: AppColors.kAccountTextColor),),
                  Spacer(),
                  Text("Ayomikun Oladejo", style: TextStyle(
                      fontSize: 13,
                      color: AppColors.kAccountTextColor),),
                ],
              ),
                YMargin(20),
                Row(
                  children: [
                    Text("Account number(Wallet ID):", style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kAccountTextColor),),
                    Spacer(),
                    Text("2134758794", style: TextStyle(
                        fontSize: 13,
                        color: AppColors.kAccountTextColor),),
                  ],
                ),
            ],),
          ),
          YMargin(20),
          Container(
            height: 128,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all( 10),
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(5),
                Row(
                  children: [
                    Text("Amount Entered", style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kAccountTextColor),),
                    Spacer(),
                    Text("\$ 200,00", style: TextStyle(
                        fontSize: 13,
                        color: AppColors.kAccountTextColor),),
                  ],
                ),
                YMargin(20),
                Row(
                  children: [
                    Text("Zenith Bank", style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kAccountTextColor),),
                    Spacer(),
                    Text("Ayomikun Oladejo", style: TextStyle(
                        fontSize: 13,
                        color: AppColors.kAccountTextColor),),
                  ],
                ),
                YMargin(20),
                Row(
                  children: [
                    Text("Account name", style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kAccountTextColor),),
                    Spacer(),
                    Text("2134758794", style: TextStyle(
                        fontSize: 13,
                        color: AppColors.kAccountTextColor),),
                  ],
                ),
              ],),
          ),
          YMargin(20),
          Row(
            children: [
              XMargin(20),
              Text("A 20 Naira charge is applicable "
                  "from the service provider.",
                style: TextStyle(fontSize: 10,color: AppColors.kAccountTextColor),),
            ],
          ),
          YMargin(20),
          PrimaryButton(
            horizontalMargin: 20,
            color: AppColors.kAccentColor,
            title: "Fund Wallet",
            onPressed: (){

            },
          )

        ],),
      ),
    );
  }
}
