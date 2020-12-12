import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/delete_wealthbox.dart';

class SavingsSummaryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SavingsSummaryScreen(),
        settings:
        RouteSettings(name: SavingsSummaryScreen().toStringShort()));
  }
  @override
  _SavingsSummaryScreenState createState() => _SavingsSummaryScreenState();
}

class _SavingsSummaryScreenState extends State<SavingsSummaryScreen> {
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
                  YMargin(50),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Savings Summary", style: TextStyle(fontFamily: AppStrings.fontMedium),),
                  ),
                  YMargin(20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    height: 380,
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
                        Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Frequency".toUpperCase(), style: TextStyle(fontSize: 11,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("Monthly", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                            ],),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("amount".toUpperCase(), style: TextStyle(fontSize: 12,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("${AppStrings.nairaSymbol}20,000", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                            ],),


                        ],),
                        YMargin(40),
                        Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("start date".toUpperCase(), style: TextStyle(fontSize: 12,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("Oct 29, 2020", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                          ],),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Next maturity date".toUpperCase(), style: TextStyle(fontSize: 11,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("Feb 29, 2020", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                          ],)
                        ],),
                        YMargin(40),
                        Text("Interest rate".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("6% P.A", style: TextStyle(
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
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                    return ConfirmSavings();
                  },isScrollControlled: true);

                    //Navigator.push(context, TopUpSuccessful.route());
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
