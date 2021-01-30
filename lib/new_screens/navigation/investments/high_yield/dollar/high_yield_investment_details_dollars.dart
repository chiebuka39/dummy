import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_dollar_name_input.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldDetailsDollar extends StatefulWidget {
  final double exchangeRate;

  const HighYieldDetailsDollar({Key key, this.exchangeRate}) : super(key: key);
  static Route<dynamic> route({double exchangeRate}) {
    return MaterialPageRoute(
      builder: (_) => HighYieldDetailsDollar(exchangeRate: exchangeRate,),
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
  void initState() {
    Provider.of<InvestmentHighYieldViewModel>(context, listen: false).getRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InvestmentHighYieldViewModel investmentModel = Provider.of(context);
    return Scaffold(
      backgroundColor: AppColors.kHighYield,
      body: Stack(
        children: [
          Positioned(
            top: 24,
            left: 15,
            // top: 24,
            // left: 20,
            child: IconButton(
              icon: Icon(
                Icons.clear,
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
              child: SvgPicture.asset(
                "images/money_glass.svg",
                width: screenHeight(context),
                height: screenWidth(context),
              )),
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
              child: Container(
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 39.0, left: 20),
                      child: Text(
                        "Zimvest High Yield Dollar",
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
                                onTap: () {
                                  print(investmentModel.gotRate.data.rate);
                                  investmentModel.exchangeRate = widget.exchangeRate;
                                  Navigator.push(
                                    context,
                                    HighYieldInvestmentDollarUniqueName.route(),
                                  );
                                },
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
            ),
          )
        ],
      ),
    );
  }
}
