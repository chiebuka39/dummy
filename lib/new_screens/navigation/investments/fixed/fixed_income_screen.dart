import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/commercial_paper_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/corporate_bond_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/euro_bond_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fbn_bond_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/promissory_note_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/treasury_bill_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';

class FixedIncomeHome extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => FixedIncomeHome(),
      settings: RouteSettings(
        name: FixedIncomeHome().toStringShort(),
      ),
    );
  }

  @override
  _FixedIncomeHomeState createState() => _FixedIncomeHomeState();
}

class _FixedIncomeHomeState extends State<FixedIncomeHome> {
  PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );
  // ScrollController listController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: screenHeight(context) / 15,
            left: screenWidth(context) / 19.8,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: ImageIcon(AssetImage("images/cancel.png"),
                  color: AppColors.kPrimaryColor),
            ),
          ),
          Positioned(
            top: screenHeight(context) / 8,
            left: screenWidth(context) / 19.8,
            child: Text(
              "Zimvest Fixed Income",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold,
                  color: AppColors.kTextColor),
            ),
          ),
          Positioned(
            top: 145,
            left: screenWidth(context) / 19.8,
            child: Container(
              height: screenHeight(context) / 18,
              width: screenWidth(context),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () => controller.jumpTo(0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Treasury Bill",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontBold,
                                color: currentIndex == 0
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kLightText5),
                          ),
                          YMargin(9.5),
                          Container(
                            height: 1,
                            width: 31,
                            color: currentIndex == 0
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightText5,
                          )
                        ],
                      ),
                    ),
                  ),
                  XMargin(20),
                  GestureDetector(
                    onTap: () => controller.jumpTo(1),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "FBN Bond",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontBold,
                                color: currentIndex == 1
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kLightText5),
                          ),
                          YMargin(9.5),
                          Container(
                            height: 1,
                            width: 31,
                            color: currentIndex == 1
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightText5,
                          )
                        ],
                      ),
                    ),
                  ),
                  XMargin(20),
                  GestureDetector(
                    onTap: () => controller.jumpTo(2),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Corporate Bond",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontBold,
                                color: currentIndex == 2
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kLightText5),
                          ),
                          YMargin(9.5),
                          Container(
                            height: 1,
                            width: 31,
                            color: currentIndex == 2
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightText5,
                          )
                        ],
                      ),
                    ),
                  ),
                  XMargin(20),
                  GestureDetector(
                    onTap: () => controller.jumpTo(3),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Euro Bond",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontBold,
                                color: currentIndex == 3
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kLightText5),
                          ),
                          YMargin(9.5),
                          Container(
                            height: 1,
                            width: 31,
                            color: currentIndex == 3
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightText5,
                          )
                        ],
                      ),
                    ),
                  ),
                  XMargin(20),
                  GestureDetector(
                    onTap: () => controller.jumpTo(4),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Promissory Note",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontBold,
                                color: currentIndex == 4
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kLightText5),
                          ),
                          YMargin(9.5),
                          Container(
                            height: 1,
                            width: 31,
                            color: currentIndex == 4
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightText5,
                          )
                        ],
                      ),
                    ),
                  ),
                  XMargin(20),
                  GestureDetector(
                    onTap: () => controller.jumpTo(5),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Commercial Paper",
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppStrings.fontBold,
                                color: currentIndex == 5
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kLightText5),
                          ),
                          YMargin(9.5),
                          Container(
                            height: 1,
                            width: 31,
                            color: currentIndex == 5
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightText5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  XMargin(40),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: screenHeight(context) / 1.3,
              width: screenWidth(context),
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  onchanged(index);
                },
                children: [
                  TreasuryBillPage(),
                  FBNBondPagePage(),
                  CorporateBondPage(),
                  EuroBondPage(),
                  PromissoryNotePage(),
                  CommercialPaperPage()
                ],
              ),
            ),
            top: 199,
            left: 20,
          )
        ],
      ),
    );
  }

  onchanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
