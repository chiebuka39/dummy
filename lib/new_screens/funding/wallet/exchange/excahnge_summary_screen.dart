import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ExchangeSummaryScreen extends StatefulWidget {
  final bool dollars;

  const ExchangeSummaryScreen({Key key, this.dollars = true}) : super(key: key);
  static Route<dynamic> route(bool dollars) {
    return MaterialPageRoute(
        builder: (_) => ExchangeSummaryScreen(dollars: dollars,),
        settings:
        RouteSettings(name: ExchangeSummaryScreen().toStringShort()));
  }
  @override
  _ExchangeSummaryScreenState createState() => _ExchangeSummaryScreenState();
}

class _ExchangeSummaryScreenState extends State<ExchangeSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      body: widget.dollars?  Container(
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
                    child: Text("Exchange To Dollars", style: TextStyle(fontFamily: AppStrings.fontMedium),),
                  ),
                  YMargin(20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    height: 245,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: AppUtils.getBoxShaddow3
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Wallet balance".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("${AppStrings.nairaSymbol} 20,000,000", style: TextStyle(
                            fontFamily: AppStrings.fontMedium,
                            fontSize: 13,color: AppColors.kGreyText
                        ),),
                        YMargin(40),
                        Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("amount in dollars".toUpperCase(), style: TextStyle(fontSize: 12,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("\$20,000", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                          ],),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Amount in naira".toUpperCase(), style: TextStyle(fontSize: 11,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Row(
                                children: [
                                  Text("${AppStrings.nairaSymbol}20,000", style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      fontSize: 13,color: AppColors.kGreyText
                                  ),),
                                  XMargin(5),
                                  Text("(1 USD =₦440)",style: TextStyle(fontSize: 10,color: AppColors.kWealth),)
                                ],
                              ),
                          ],)
                        ],),


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
                    Navigator.push(context, TopUpSuccessful.route());
                  },
                  child: Text("Tap to confirm", style: TextStyle(fontFamily: AppStrings.fontMedium,
                      color: Colors.white),),
                )
              ],),
            ),
          )
        ],),
      ):Container(
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
                    child: Text("Exchange To Naira", style: TextStyle(fontFamily: AppStrings.fontMedium),),
                  ),
                  YMargin(20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    height: 245,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: AppUtils.getBoxShaddow3
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Wallet balance".toUpperCase(), style: TextStyle(fontSize: 12,
                          color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                        YMargin(15),
                        Text("\$ 20,000,000", style: TextStyle(
                            fontFamily: AppStrings.fontMedium,
                            fontSize: 13,color: AppColors.kGreyText
                        ),),
                        YMargin(40),
                        Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("amount in naira".toUpperCase(), style: TextStyle(fontSize: 12,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Row(
                                children: [
                                  Text("${AppStrings.nairaSymbol}20,000", style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      fontSize: 13,color: AppColors.kGreyText
                                  ),),

                                  XMargin(5),
                                  Text("(1 USD =₦440)",style: TextStyle(fontSize: 10,color: AppColors.kWealth),)
                                ],
                              ),

                            ],),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Amount in dollars".toUpperCase(), style: TextStyle(fontSize: 11,
                                color: AppColors.kSecondaryText,fontFamily: AppStrings.fontNormal,),),
                              YMargin(15),
                              Text("\$5,000", style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,color: AppColors.kGreyText
                              ),),
                            ],)
                        ],),


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
                    Navigator.push(context, TopUpSuccessful.route());
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
