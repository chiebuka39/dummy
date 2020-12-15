import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/investment_high_yield_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';

class WealthScreen extends StatefulWidget {
    static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => WealthScreen(),
      settings: RouteSettings(
        name: WealthScreen().toStringShort(),
      ),
    );
  }

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Wealth",
                    style: TextStyle(
                        fontSize: 16, fontFamily: AppStrings.fontBold),
                  ),
                  Spacer(),
                  Container(
                    width: 115,
                    height: 28,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColorLight,
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("images/gift.svg", color: AppColors.kPrimaryColor,),
                        XMargin(6),
                        Text(
                          "Earn Free Cash",
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: AppStrings.fontBold,
                              color: AppColors.kPrimaryColor),
                        )
                      ],
                    ),
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
                      color: AppColors.kPrimaryColorLight,
                      borderRadius: BorderRadius.circular(13)),
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        left: showInvest == true ? tabWidth / 2 : 0,
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
                                  showInvest = false;
                                });
                              },
                              child: Container(
                                  child: Center(
                                      child: Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: showInvest == false
                                        ? Colors.white
                                        : AppColors.kPrimaryColor),
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
                                style: TextStyle(
                                    fontSize: 12,
                                    color: showInvest == true
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
            YMargin(30),
            showInvest
                ? Expanded(
                    child: Column(
                      children: [
                        ActionBoxWidget(
                          img: "high_yield",
                          onTap: (){
                            Navigator.push(context, InvestmentHighYieldScreen.route());
                          },
                          title: "Zimvest High Yield",
                          desc:
                              "Start saving in a disciplined manner with the WealthBox Savings Plan",
                          color: AppColors.kHighYield,
                        ),
                        ActionBoxWidget(
                          img: "fixed_income",
                          onTap: () => Navigator.push(context, FixedIncomeHome.route()),
                            title: "Zimvest Fixed Income",
                            desc: "This savings plan assists you save in a ",
                            color: AppColors.kFixed),
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        ActionBoxWidget(
                            title: "Zimvest wealth box",
                            desc: "This savings plan assists you save in a "
                                "disciplined manner.",
                            color: AppColors.kWealth),
                        ActionBoxWidget(
                            title: "Zimvest Aspire",
                            desc: "This savings plan assists you save in a "
                                "disciplined manner.",
                            color: AppColors.kAspire),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
