import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_dollar_name_input.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldDetailsDollar extends StatefulWidget {
  final String duration;

  const HighYieldDetailsDollar({Key key, this.duration}) : super(key: key);
  static Route<dynamic> route(String dur) {
    return MaterialPageRoute(
      builder: (_) => HighYieldDetailsDollar(
        duration: dur,
      ),
      settings: RouteSettings(
        name: HighYieldDetailsDollar().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldDetailsDollarState createState() => _HighYieldDetailsDollarState();
}

class _HighYieldDetailsDollarState extends State<HighYieldDetailsDollar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHighYield,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight(context) / 10,
            left: screenWidth(context) / 15,
            child: IconButton(
              icon: ImageIcon(
                AssetImage("images/cancel.png"),
                color: AppColors.kWhite,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: screenHeight(context) / 10,
            left: screenWidth(context) / 15,
            right: screenWidth(context) / 15,
            bottom: screenHeight(context) / 1.6,
            child: SvgPicture.asset("images/money_glass.svg")
          ),
          Positioned(
            top: screenHeight(context) / 2.5,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight(context) / 1.5,
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 39.0, left: 20),
                    child: Text(
                      "Zimvest High Yield Dollar ${widget.duration}",
                      style: TextStyle(
                          fontSize: 15, fontFamily: AppStrings.fontBold),
                    ),
                  ),
                  verticalSpace(18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "This investment is designed for investors with moderate risk tolerance and a short to medium-term investment horizon.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 13, fontFamily: AppStrings.fontLight),
                    ),
                  ),
                  verticalSpace(33),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                AssetImage("images/star.png"),
                                color: AppColors.kPrimaryColor,
                              ),
                              Text(
                                "Earn great returns.",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: AppStrings.fontLight),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                AssetImage("images/star.png"),
                                color: AppColors.kPrimaryColor,
                              ),
                              Text(
                                "Withdraw at the first day of every quarter.",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: AppStrings.fontLight),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                AssetImage("images/star.png"),
                                color: AppColors.kPrimaryColor,
                              ),
                              Text(
                                "Save daily, weekly or monthly.",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: AppStrings.fontLight),
                              ),
                            ],
                          ),
                          verticalSpace(112),
                          Center(
                            child: PrimaryButtonNew(
                              title: "Get Started",
                              onTap: () => Navigator.push(
                                context,
                                HighYieldInvestmentDollarUniqueName.route(widget.duration),
                              ),
                            ),
                          ),
                          verticalSpace(63),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
