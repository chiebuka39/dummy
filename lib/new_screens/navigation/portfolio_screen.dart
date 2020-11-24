import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  bool showInvest = false;

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [

                Text("Portfolio", style: TextStyle(fontSize: 16, fontFamily: AppStrings.fontBold),),
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
          YMargin(33),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                width: tabWidth,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.kGrey,
                    borderRadius: BorderRadius.circular(13)),
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      left: showInvest == true ? tabWidth/2 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: tabWidth/2,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.kGreyText,
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
                                    showInvest = false;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: showInvest == false?Colors.white:AppColors.kGreyText
                                          ),
                                        ))),
                              )),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showInvest = true;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                          "Invest",
                                          style: TextStyle(fontSize: 12,
                                          color: showInvest == true?Colors.white:AppColors.kGreyText),
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
          YMargin(30),
          showInvest ?PortfolioInvestmentWidget():Expanded(child: Column(children: [
            ActionBoxWidget(title: "Zimvest wealth box", desc: "This savings plan assists you save in a "
                "disciplined manner."),
            ActionBoxWidget(title: "Zimvest Aspire", desc: "This savings plan assists you save in a "
                "disciplined manner."),
          ],)),

        ],),
      ),
    );
  }
}

class PortfolioInvestmentWidget extends StatefulWidget {
  const PortfolioInvestmentWidget({
    Key key,
  }) : super(key: key);

  @override
  _PortfolioInvestmentWidgetState createState() => _PortfolioInvestmentWidgetState();
}

class _PortfolioInvestmentWidgetState extends State<PortfolioInvestmentWidget> {
  bool naira = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(children: [
      YMargin(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          width: 100,
          height: 60,
          child: Stack(children: [
            Row(children: [
              GestureDetector(
                onTap:(){
                  setState(() {
                    naira = true;
                  });
      },
                  child: Text("Naira")),
              Spacer(),
              GestureDetector(
                  onTap:(){
                    setState(() {
                      naira = false;
                    });
                  },
                  child: Text("Dollar")),


            ],),
            AnimatedPositioned(
              top: 25,
                left: naira ?5: 62,
                child: Container(
                  height: 3,
                  width: 30,
                  decoration: BoxDecoration(color: AppColors.kGreyText),
                ),
                duration: Duration(milliseconds: 300))
          ],),
        )
      ],),
      Spacer(),
      SizedBox(
        width: 200,
          child: Text("You currently don’t have a savings plan",
            textAlign: TextAlign.center,style: TextStyle(fontFamily: AppStrings.fontNormal,
                color: AppColors.kGreyText,height: 1.6),)),
      YMargin(40),
      PrimaryButtonNew(
        title: "Start Saving",
      ),
      YMargin(80),
    ]));
  }
}
