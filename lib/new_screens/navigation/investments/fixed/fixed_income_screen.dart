import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/commercial_papers/commercial_paper_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/corporate_bonds/corporate_bond_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/euro_bond/euro_bond_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fbn_bonds/fbn_bond_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/promissory_note/promissory_note_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/treasury_bills/treasury_bill_screen.dart';
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
  PageController controller;
  ScrollController listController;
  double currentIndex = 0.0;

  @override
  void initState() {
    controller = PageController();
    listController = ScrollController();
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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: ImageIcon(AssetImage("images/cancel.png"),
              color: AppColors.kPrimaryColor),
        ),
        elevation: 0,
        backgroundColor: AppColors.kWhite,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
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
            top: 40,
            left: screenWidth(context) / 19.8,
            child: Container(
              height: screenHeight(context) / 18,
              width: screenWidth(context),
              child: ListView(
                controller: listController,
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      controller.jumpToPage(0);
                    },
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
                  InkWell(
                    onTap: () {
                      controller.jumpToPage(1);
                      // print(listController.position.pixels);
                    },
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
                  InkWell(
                    onTap: () {
                      controller.jumpToPage(2);
                    },
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
                  InkWell(
                    onTap: () {
                      controller.jumpToPage(3);
                    },
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
                  InkWell(
                    onTap: () {
                      controller.jumpToPage(4);
                    },
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
                  InkWell(
                    onTap: () {
                      controller.jumpToPage(5);
                    },
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
                physics: NeverScrollableScrollPhysics(),
                controller: controller,
                onPageChanged: onchanged,
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
            top: 94,
            // left: 20,
          ),
        ],
      ),
    );
  }

  onchanged(int index) {
    setState(() {
      currentIndex = controller.page;
    });
  }
}
