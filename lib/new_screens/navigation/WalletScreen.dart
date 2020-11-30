import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zimvest/new_screens/funding/wallet/exchange/exchange_to_dollars.dart';
import 'package:zimvest/new_screens/funding/wallet/verification_needed_screen.dart';
import 'package:zimvest/new_screens/funding/wallet/wallet_withdraw_to.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/new_screens/navigation/widgets/transaction_item_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  PageController controller = PageController();

  bool showTopUp = true;

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(

        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.kSecondaryColor,
              child: SafeArea(
                child: Column(

                  children: [
                  Row(
                    children: [
                      Text("Wallet", style: TextStyle(color: AppColors.kWhite),),

                    ],
                  ),
                    YMargin(20),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: PageView(children: [
                        Container(

                          child: Column(children: [
                            Text("Naira Wallet", style: TextStyle(color: AppColors.kWhite),),
                            YMargin(15),
                            Row(
                              children: [
                                Spacer(),
                                MoneyTitleWidget(amount: 200000,textColor: AppColors.kWhite,),
                                Spacer(),
                              ],
                            ),
                            YMargin(10),
                            Text("Balance", style: TextStyle(color: AppColors.kWhite,fontSize: 11,
                                fontFamily: AppStrings.fontNormal),),
                            YMargin(30),
                            Row(

                              children: [
                                Expanded(
                                  child: Center(
                                    child: GestureDetector(
                                      onTap:(){
                                        Navigator.of(context).push(WalletWithdrawToScreen.route());
                                      },
                                      child: Container(child: Column(children: [
                                        Container(
                                            height:35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: AppColors.kWhite,
                                                shape: BoxShape.circle
                                            ),
                                            child: Center(child: SvgPicture.asset("images/new/withdraw1.svg", color: AppColors.kPrimaryColor,))),
                                        YMargin(12),
                                        Text("Withdraw", style: TextStyle(
                                            fontSize: 12,color: AppColors.kWhite,
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
                                                color: AppColors.kWhite,
                                                shape: BoxShape.circle
                                            ),
                                            child: Center(child: SvgPicture.asset("images/new/top_up.svg",color: AppColors.kPrimaryColor,))),
                                        YMargin(12),
                                        Text("Fund Wallet", style: TextStyle(
                                            fontSize: 12,color: AppColors.kWhite,
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
                                        Navigator.push(context, ExchangeToDollarsScreen.route(true));
                                      },
                                      child: Container(child: Column(children: [
                                        Container(
                                            height:35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: AppColors.kWhite,
                                                shape: BoxShape.circle
                                            ),
                                            child: Center(child: SvgPicture.asset("images/new/swap.svg",color: AppColors.kPrimaryColor,))),
                                        YMargin(12),
                                        Text("Exchange", style: TextStyle(
                                            fontSize: 12,color: AppColors.kWhite,
                                            fontFamily: AppStrings.fontNormal
                                        ),)
                                      ],),),
                                    ),
                                  ),
                                ),
                              ],),

                          ],),
                        ),
                        Container(

                          child: Column(children: [
                            Text("Naira Wallet", style: TextStyle(color: AppColors.kWhite),),
                            YMargin(15),
                            Row(
                              children: [
                                Spacer(),
                                MoneyTitleWidget(amount: 200000,textColor: AppColors.kWhite,),
                                Spacer(),
                              ],
                            ),
                            YMargin(10),
                            Text("Balance", style: TextStyle(color: AppColors.kWhite,fontSize: 11,
                                fontFamily: AppStrings.fontNormal),),
                            YMargin(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(WalletWithdrawToScreen.route());
                                    },
                                    child: Container(child: Column(children: [
                                      Container(
                                          height:35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: AppColors.kWhite,
                                              shape: BoxShape.circle
                                          ),
                                          child: Center(child: SvgPicture.asset("images/new/withdraw1.svg", color: AppColors.kPrimaryColor,))),
                                      YMargin(12),
                                      Text("Withdraw", style: TextStyle(
                                          fontSize: 12,color: AppColors.kWhite,
                                          fontFamily: AppStrings.fontNormal
                                      ),)
                                    ],),),
                                  ),
                                ),
                                XMargin(68),
                                Center(
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, ExchangeToDollarsScreen.route(false));
                                    },
                                    child: Container(child: Column(children: [
                                      Container(
                                          height:35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color: AppColors.kWhite,
                                              shape: BoxShape.circle
                                          ),
                                          child: Center(child: SvgPicture.asset("images/new/swap.svg",color: AppColors.kPrimaryColor,))),
                                      YMargin(12),
                                      Text("Exchange", style: TextStyle(
                                          fontSize: 12,color: AppColors.kWhite,
                                          fontFamily: AppStrings.fontNormal
                                      ),)
                                    ],),),
                                  ),
                                ),
                              ],),

                          ],),
                        ),
                      ],),

                    ),
                    YMargin(15),
                    SmoothPageIndicator(
                        controller: controller,  // PageController
                        count: 2,
                        effect:  WormEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: AppColors.kPrimaryColor,
                            dotColor: AppColors.kPrimaryColor.withOpacity(0.35)
                        ),  // your preferred effect
                        onDotClicked: (index){

                        }
                    )
                ],),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: DraggableScrollableSheet(
                initialChildSize: 0.55,
                minChildSize: 0.55,
                maxChildSize: 0.8,
                builder: (BuildContext context, myscrollController) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ListView(
                      padding: EdgeInsets.only(top: 30),
                      physics: BouncingScrollPhysics(),
                      controller: myscrollController,
                      children: [
                        Row(
                          children: <Widget>[
                            Spacer(),
                            Container(
                              width: tabWidth,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColorLight,
                                  borderRadius: BorderRadius.circular(13)),
                              child: Stack(
                                children: <Widget>[
                                  AnimatedPositioned(
                                    left: showTopUp == false ? tabWidth / 2 : 0,
                                    duration: Duration(milliseconds: 300),
                                    child: Container(
                                      width: tabWidth / 2,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: AppColors.kPrimaryColor,
                                          borderRadius: BorderRadius.circular(13)),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showTopUp = true;
                                                });
                                              },
                                              child: Container(
                                                  child: Center(
                                                      child: Text(
                                                        "Top Ups",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: showTopUp == true
                                                                ? Colors.white
                                                                : AppColors.kPrimaryColor),
                                                      ))),
                                            )),
                                        Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showTopUp = false;
                                                });
                                              },
                                              child: Container(
                                                  child: Center(
                                                      child: Text(
                                                        "Withdrawals",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: showTopUp == false
                                                                ? Colors.white
                                                                : AppColors.kPrimaryColor),
                                                      ))),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        ...List.generate(6, (index) => TransactionItemWidget())


                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
