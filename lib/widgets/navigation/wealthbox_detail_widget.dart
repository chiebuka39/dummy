import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:zimvest/new_screens/account/temp_login_screen.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/navigation/portfolio_screen.dart';
import 'package:zimvest/new_screens/funding/top_up_screen.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/wealth_activites.dart';
import 'package:zimvest/widgets/navigation/wealth_more.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class WealthBoxDetailsWidget extends StatelessWidget {
  const WealthBoxDetailsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 130,
      child: Scaffold(
        backgroundColor: AppColors.kWhite,
        body: ListView(
          children: [
            YMargin(10),
            Center(child: Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.kAccountTextColor
              ),
            ),),
            YMargin(27),
            Row(
              children: [
                XMargin(20),
                Text("Zimvest WealthBox", style: TextStyle(
                    fontSize: 15, fontFamily: AppStrings.fontBold
                ),),
                Spacer(),
                IconButton(icon: Icon(Icons.more_horiz_rounded), onPressed: (){
                  showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                    return WealthMore(delete: false,);
                  },isScrollControlled: true);
                })
              ],
            ),
            YMargin(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Balance", style: TextStyle(fontSize: 12,fontFamily: AppStrings.fontNormal),),
                  YMargin(10),
                  MoneyTitleWidget(
                    amount: 100000,
                  ),
                  YMargin(25),
                  Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Accrued Interest",
                          style: TextStyle(
                              fontFamily: AppStrings.fontNormal,
                              color: AppColors.kGreyText,
                              fontSize: 11
                          ),),
                        YMargin(4),
                        Transform.translate(
                          offset: Offset(-8,0),
                          child: Row(children: [
                            Icon(Icons.arrow_drop_up_outlined),
                            Text("${AppStrings.nairaSymbol}2,000",
                              style: TextStyle(fontFamily: AppStrings.fontMedium,fontSize: 11),),
                            XMargin(5),
                            Text("Past 24h",
                              style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontNormal),),
                          ],),
                        )
                      ],),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Interest P.A",
                          style: TextStyle(
                              fontFamily: AppStrings.fontNormal,
                              color: AppColors.kGreyText,
                              fontSize: 11
                          ),),
                        YMargin(4),
                        Text("5%",
                          style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontNormal),),
                      ],),
                  ],),
                  YMargin(30),
                  Row(children: [
                    Text("Goal", style: TextStyle(fontSize: 14,
                        fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText),),
                    Spacer(),
                    Text("Edit", style: TextStyle(fontSize: 11,
                        fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText))
                  ],),
                  YMargin(15),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: AppUtils.getBoxShaddow,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    child: Row(children: [
                      CircularPercentIndicator(
                        radius: 70.0,
                        lineWidth: 7.0,
                        animation: true,
                        percent: 0.7,
                        center: new Text(
                          "7%",
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: AppColors.kPrimaryColor,
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text("${AppStrings.nairaSymbol}5,000,000", style: TextStyle(
                              fontFamily: AppStrings.fontMedium,color: AppColors.kGreyText
                          ),),
                          YMargin(8),
                          Text("Goal Amount", style: TextStyle(fontSize: 11,
                              fontFamily: AppStrings.fontNormal,color: AppColors.kGreyText
                          ),),
                          YMargin(30),
                          Text("Feb 02 2021", style: TextStyle(
                              fontFamily: AppStrings.fontMedium,color: AppColors.kGreyText
                          ),),
                          YMargin(8),
                          Text("Due Date", style: TextStyle(fontSize: 11,
                              fontFamily: AppStrings.fontNormal,color: AppColors.kGreyText
                          ),),
                          Spacer(),
                        ],),
                      Spacer(),

                    ],),
                  )
                ],
              ),
            ),
            YMargin(30),
            Row(

              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap:(){
                        Navigator.of(context).push(TopUpScreen.route());
      },
                      child: Container(child: Column(children: [
                        Container(
                            height:35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.kGreyBg,
                                shape: BoxShape.circle
                            ),
                            child: Center(child: SvgPicture.asset("images/new/top_up.svg"))),
                        YMargin(12),
                        Text("Top Up", style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppStrings.fontNormal
                        ),)
                      ],),),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(WithdrawWealthScreen.route());
                      },
                      child: Container(child: Column(children: [
                        Container(
                            height:35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.kGreyBg,
                                shape: BoxShape.circle
                            ),
                            child: Center(child: SvgPicture.asset("images/new/top_up.svg"))),
                        YMargin(12),
                        Text("Withdraw", style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppStrings.fontNormal
                        ),)
                      ],),),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(child: Column(children: [
                      Container(
                          height:35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: AppColors.kGreyBg,
                              shape: BoxShape.circle
                          ),
                          child: Center(child: SvgPicture.asset("images/new/top_up.svg"))),
                      YMargin(12),
                      Text("Pause", style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppStrings.fontNormal
                      ),)
                    ],),),
                  ),
                ),
              ],),
            YMargin(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Text("Activities", style: TextStyle(fontSize: 14,
                    fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText),),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return WealthBoxActivities();
                    },isScrollControlled: true);
                  },
                  child: Text("See all", style: TextStyle(fontSize: 11,
                      fontFamily: AppStrings.fontMedium, color: AppColors.kGreyText)),
                )
              ],),
            ),
            ...List.generate(4, (index) {
              return WealthBoxActivity();
            })

          ],
        ),
      ),
    );
  }
}

