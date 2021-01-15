import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_naira_name_input.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldDetails extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => HighYieldDetails(),
      settings: RouteSettings(
        name: HighYieldDetails().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldDetailsState createState() => _HighYieldDetailsState();
}

class _HighYieldDetailsState extends State<HighYieldDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kHighYield,
      body: Stack(
        children: [
          Positioned(
            top: 24,
            left: 15,
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
              top: screenHeight(context) / 15.0370370371,
              left: screenHeight(context) / 9.5,
              right: screenHeight(context) / 9.5,
              bottom: screenHeight(context) / 1.65426695842,
              child: SvgPicture.asset("images/money_glass.svg")),
          Positioned(
            top: screenHeight(context) / 2.25,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight(context) / 1.4,
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
                      "Zimvest High Yield Naira",
                      style: TextStyle(
                          fontSize: 15, fontFamily: AppStrings.fontBold),
                    ),
                  ),
                  verticalSpace(screenHeight(context) / 42),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "This investment is designed for investors with moderate risk tolerance and a short to medium-term investment horizon.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 13,
                          fontFamily: AppStrings.fontLight),
                    ),
                  ),
                  verticalSpace(screenHeight(context) / 22.2352941176),
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
                          verticalSpace(11),
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
                          verticalSpace(11),
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
                          verticalSpace(46),
                          Center(
                            child: PrimaryButtonNew(
                              title: "Get Started",
                              onTap: () => Navigator.push(
                                context,
                                HighYieldInvestmentNairaUniqueName.route(),
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
