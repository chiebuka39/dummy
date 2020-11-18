import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.kGrey),
                      child:
                          Center(child: SvgPicture.asset("images/profile.svg"))),
                  XMargin(20),
                  Text("Hi, Emmanuel"),
                  Spacer(),
                  Container(
                    width: 115,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.kGrey,
                      borderRadius: BorderRadius.circular(14)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      SvgPicture.asset("images/gift.svg"),
                      XMargin(6),
                      Text("Earn Free Cash",
                        style: TextStyle(fontSize: 10,fontFamily: AppStrings.fontNormal),)
                    ],),
                  )
                ],
              ),
            ),
            Container(
              height: 165,
              child: PageView(
                controller: controller,
                children: [
                  Container(
                    height: 165,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Naira Portfolio",
                          style: TextStyle(
                              fontFamily: AppStrings.fontMedium),),
                        YMargin(12),
                        Row(children: [
                          Transform.translate(
                              offset:Offset(0,-4),
                              child: Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 14),)),
                          XMargin(2),
                          Text("000,000",
                            style: TextStyle(fontSize: 25, fontFamily: AppStrings.fontMedium),),
                          XMargin(3),
                          Transform.translate(
                            offset:Offset(0,-4),
                            child: Text(".00",
                              style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium),),
                          ),
                        ],),
                        YMargin(16),
                        Row(children: [
                          Icon(Icons.arrow_drop_up_outlined),
                          Text("${AppStrings.nairaSymbol}0",
                            style: TextStyle(fontFamily: AppStrings.fontMedium),),
                          XMargin(5),
                          Text("(0.00%)",
                            style: TextStyle(fontFamily: AppStrings.fontMedium),),
                          XMargin(5),
                          Text("Past 24h",
                            style: TextStyle(),),
                          Spacer(),
                          Transform.translate(
                            offset: Offset(0,2),
                            child: GestureDetector(
                              child: Row(children: [
                                Text("Portfolio Breakdown", style: TextStyle(color: AppColors.kGreyText,
                                    fontSize: 11,fontFamily: AppStrings.fontNormal),),
                                Icon(Icons.navigate_next_rounded, color: AppColors.kGreyText,size: 19,)
                              ],),
                            ),
                          )

                        ],)
                      ],),),
                  Container(
                    height: 165,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dollar Portfolio",
                          style: TextStyle(
                              fontFamily: AppStrings.fontMedium),),
                        YMargin(12),
                        Row(children: [
                          Transform.translate(
                              offset:Offset(0,-4),
                              child: Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 14),)),
                          XMargin(2),
                          Text("000,000",
                            style: TextStyle(fontSize: 25, fontFamily: AppStrings.fontMedium),),
                          XMargin(3),
                          Transform.translate(
                            offset:Offset(0,-4),
                            child: Text(".00",
                              style: TextStyle(fontSize: 14, fontFamily: AppStrings.fontMedium),),
                          ),
                        ],),
                        YMargin(16),
                        Row(children: [
                          Icon(Icons.arrow_drop_up_outlined),
                          Text("${AppStrings.nairaSymbol}0",
                            style: TextStyle(fontFamily: AppStrings.fontMedium),),
                          XMargin(5),
                          Text("(0.00%)",
                            style: TextStyle(fontFamily: AppStrings.fontMedium),),
                          XMargin(5),
                          Text("Past 24h",
                            style: TextStyle(),),
                          Spacer(),
                          Transform.translate(
                            offset: Offset(0,2),
                            child: GestureDetector(
                              child: Row(children: [
                                Text("Portfolio Breakdown", style: TextStyle(color: AppColors.kGreyText,
                                    fontSize: 11,fontFamily: AppStrings.fontNormal),),
                                Icon(Icons.navigate_next_rounded, color: AppColors.kGreyText,size: 19,)
                              ],),
                            ),
                          )

                        ],)
                      ],),),
                ],
              ),
            ),

            SmoothPageIndicator(
                controller: controller,  // PageController
                count: 2,
                effect:  WormEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    activeDotColor: AppColors.kGreyText
                ),  // your preferred effect
                onDotClicked: (index){

                }
            )
          ],
        ),
      ),
    );
  }
}
