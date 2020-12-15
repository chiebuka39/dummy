import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/widgets/earn_free_cash.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';

class WealthScreen extends StatefulWidget {
  @override
  _WealthScreenState createState() => _WealthScreenState();
}

class _WealthScreenState extends State<WealthScreen> {
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

                Text("Wealth", style: TextStyle(fontSize: 16, fontFamily: AppStrings.fontBold),),
                Spacer(),
                EarnFreeCashWidget()
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
                    color: AppColors.kPrimaryColorLight,
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
                                    showInvest = false;
                                  });
                                },
                                child: Container(
                                    child: Center(
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: showInvest == false?Colors.white:AppColors.kPrimaryColor
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
                                          color: showInvest == true?Colors.white:AppColors.kPrimaryColor),
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
          showInvest ?Expanded(child: Column(children: [
            ActionBoxWidget(title: "Zimvest High Yield", desc: "This savings plan assists you save in a "
                "disciplined manner.", color: AppColors.kHighYield,img: 'high',),
            ActionBoxWidget(title: "Zimvest Fixed Income", desc: "This savings plan assists you save in a "
                "disciplined manner.", color: AppColors.kFixed,img: 'fixed',),
          ],)):Expanded(child: Column(children: [
            ActionBoxWidget(title: "Zimvest wealth box", desc: "This savings plan assists you save in a "
                "disciplined manner.", color: AppColors.kWealth),
            ActionBoxWidget(title: "Zimvest Aspire", desc: "This savings plan assists you save in a "
                "disciplined manner.", color: AppColors.kAspire, img: 'aspire',),
          ],)),

        ],),
      ),
    );
  }
}