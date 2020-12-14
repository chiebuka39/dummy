import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zimvest/new_screens/account/create_account.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          height: height * 0.7,
          child: PageView(
            controller: controller,
            children: [
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                SvgPicture.asset("images/new/zed.svg"),
                YMargin(46),
                Text("Zimvest", style: TextStyle(fontSize: 30, fontFamily: "Caros-Medium"),),
                YMargin(20),
                SizedBox(
                    width: 250,
                    child: Text("We help you build wealth the easy and painless way",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: AppStrings.fontNormal),)),
                YMargin(50)
            ],),),
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container(
                  color: AppColors.kFixed,
                    child: SvgPicture.asset("images/new/fin-goals.svg",))),
                YMargin(46),
                Text("Reach Your financial Goals", style: TextStyle(fontSize: 17, fontFamily: AppStrings.fontBold),),
                YMargin(20),
                SizedBox(
                    width: 230,
                    child: Text("Save, Invest, and build for tomorrow today.",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: AppStrings.fontNormal),)),

            ],),),
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container(
                  color: AppColors.kHighYield,
                    child: SvgPicture.asset("images/new/money-smart.svg",))),
                YMargin(46),
                Text("Be Money Smart", style: TextStyle(fontSize: 17, fontFamily: AppStrings.fontBold),),
                YMargin(20),
                SizedBox(
                    width: 230,
                    child: Text("Use simple financial intelligence tools to make informed money decisions",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: AppStrings.fontNormal),)),

            ],),),
            Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container(
                  color: AppColors.kAspire,
                    child: SvgPicture.asset("images/new/get-ahead.svg",))),
                YMargin(46),
                Text("Get Ahead", style: TextStyle(fontSize: 17, fontFamily: AppStrings.fontBold),),
                YMargin(20),
                SizedBox(
                    width: 230,
                    child: Text("Enjoy low-risk high-yield investment and savings portfolios by a regulated asset manager",
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: AppStrings.fontNormal),)),

            ],),),
          ],),
        ),
        YMargin(40),
        SmoothPageIndicator(
          count: 4,
          controller: controller,
          effect: WormEffect(
            activeDotColor: AppColors.kPrimaryColor,
            dotColor: AppColors.kGreyBg,
            spacing: 8,
            dotHeight: 7,
            dotWidth: 7

          ),

          
        ),
        YMargin(30),
        PrimaryButtonNew(
            onTap: (){
              Navigator.of(context).push(CreateAccountScreen.route());
            },
          title: "Create Account",
        ),
        YMargin(15),
        FlatButton(onPressed: (){
          Navigator.of(context).push(LoginScreen.route());
          // MaterialPageRoute(builder: )
        }, child: Text("Log In",style: TextStyle(fontFamily: "Caros-Medium"),)),
        Spacer(),
      ],),
    );
  }
}


