import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/investment_high_yield_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/wealth_box_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

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

  ABSSavingViewModel savingViewModel;

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    double tabWidth = MediaQuery.of(context).size.width / 1.18;
    return Scaffold(
      body: Column(
        children: [
          YMargin(42),
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
                      SvgPicture.asset(
                        "images/gift.svg",
                        color: AppColors.kPrimaryColor,
                      ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
          ),
          YMargin(22),
          showInvest
              ? Expanded(
                  child: Column(
                    children: [
                      ActionBoxWidget(
                        img: "high",
                        onTap: () {
                          Navigator.push(
                              context, InvestmentHighYieldScreen.route());
                        },
                        title: "Zimvest High Yield",
                        desc: "This plan, which is similar to fixed"
                            " deposits run by banks, offers you"
                            "competitive interest rate.",
                        color: AppColors.khighyieldCard,
                        
                      ),
                      ActionBoxWidget(
                          img: "fixed",
                          onTap: () => Navigator.push(
                              context, FixedIncomeHome.route()),
                          title: "Zimvest Fixed Income",
                          desc: "Invest in fixed income vehicles such as Treasury Bills, FGN Bonds, Corporate Bonds, and Eurobonds",
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
                          img: 'aspire',
                          title: "Zimvest Aspire",
                          desc: "This savings plan assists you save in a "
                              "disciplined manner.",
                          color: AppColors.kAspire),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
