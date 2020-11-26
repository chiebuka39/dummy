import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ConfirmWithdrawalScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ConfirmWithdrawalScreen(),
        settings:
        RouteSettings(name: ConfirmWithdrawalScreen().toStringShort()));
  }
  @override
  _ConfirmWithdrawalScreenState createState() => _ConfirmWithdrawalScreenState();
}

class _ConfirmWithdrawalScreenState extends State<ConfirmWithdrawalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),

              ),
              boxShadow: AppUtils.getBoxShaddow3
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButton(
                    color: AppColors.kPrimaryColor,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  YMargin(70),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Review"),
                  ),
                  YMargin(20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      boxShadow: AppUtils.getBoxShaddow3
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Plan name".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("Zimvest WealthBox", style: TextStyle(
                            fontFamily: AppStrings.fontMedium,
                            fontSize: 13,color: AppColors.kGreyText
                        ),),
                        YMargin(40),
                        Text("amount".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("${AppStrings.nairaSymbol}20,000", style: TextStyle(
                            fontFamily: AppStrings.fontMedium,
                            fontSize: 13,color: AppColors.kGreyText
                        ),),
                    ],),
                  )
              ],),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              child: Column(children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, SelectBankAccount.route());
                  },
                  child: Text("Tap to confirm", style: TextStyle(fontFamily: AppStrings.fontMedium,
                      color: Colors.white),),
                )
              ],),
            ),
          )
        ],),
      ),
    );
  }
}
