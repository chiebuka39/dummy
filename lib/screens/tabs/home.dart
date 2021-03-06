import 'dart:math';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/styles/styles.dart';
import 'package:zimvest/utils/enums.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/bar_charts.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/circular_progress.dart';
import 'package:zimvest/widgets/donut_chart.dart';
import 'package:zimvest/widgets/generic_widgets.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FlutterMoneyFormatter amount;
  PageController controller;
  PageController secondController;
  PageController thirdController;
  PageController aspireController;
  List<String> _wealthOptions;
  List<String> _aspireOptions;
  List<String> _mutualOptions;

  double currentIndexPage = 0;

  ZimType _zimType;

  @override
  void initState() {
    controller = PageController(initialPage: 0, viewportFraction: 0.90);
    aspireController = PageController(initialPage: 0, viewportFraction: 0.90);
    secondController = PageController(initialPage: 0, viewportFraction: 0.90);
    thirdController = PageController();

    _zimType = ZimType.WEALTH;
    _aspireOptions = ["", ""];
    _wealthOptions = ["", "",""];
    _mutualOptions = ["", ""];

    controller.addListener(() {
      setState(() {
        currentIndexPage = controller.page;
      });
    });
    amount = FlutterMoneyFormatter(
        amount: 10000000, settings: MoneyFormatterSettings(fractionDigits: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 255,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.kPrimaryColor),
          child: SafeArea(
            child: Column(
              children: [
                YMargin(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back",
                            style: TextStyle(
                                fontSize: 16, color: AppColors.kWhite),
                          ),
                          Text(
                            "Ayomikun,",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Caros-Medium",
                                color: AppColors.kWhite),
                          ),
                        ],
                      ),
                      Spacer(),
                      NotificationIdentifier(),
                      XMargin(12),
                      CircularProfileAvatar(
                        AppStrings.avatar,
                        radius: 17,
                      )
                    ],
                  ),
                ),
                YMargin(25),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white.withOpacity(0.5),
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "My Dollar portfolio balance",
                          style: TextStyle(
                              color: AppColors.kLightTitleText, fontSize: 13),
                        ),
                        Text(
                          amount.output.symbolOnLeft,
                          style: TextStyle(
                              fontFamily: "Caros-Bold",
                              color: AppColors.kWhite,
                              fontSize: 27),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white.withOpacity(0.5),
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                YMargin(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Accrued Interest",
                        style: AppStyles.tinyTitle,
                      ),
                      XMargin(10),
                      Text(
                        "\u20A6${amount.output.nonSymbol}",
                        style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 12,
                            fontFamily: "Caros-Bold"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightBG,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(16))),
              child: ListView(
                children: [
                  _buildZimSelector(),
                  YMargin(5),
                  _buildZimSelectedDetails(),
                  YMargin(6),
                  _buildZimDots(),
                  YMargin(20),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: thirdController,
                      children: [
                        Row(
                          children: [
                            Opacity(
                                opacity: 0,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {},
                                )),
                            Spacer(),
                            Container(
                                height: 200,
                                width: 200,
                                child: DonutPieChart.withSampleData()),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                print("ooo");
                                thirdController.animateToPage(1,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                thirdController.animateToPage(0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                            ),
                            Spacer(),
                            Container(
                                height: 200,
                                width: 250,
                                child: SimpleBarChart.withSampleData()),
                            Spacer(),
                            Opacity(
                              opacity: 0,
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  print("ooo");
                                  thirdController.animateToPage(1,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 160,
                    child: PageView(
                      controller: secondController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SecondaryActivityWidget(),
                        SecondaryActivityWidget(
                          bg: AppColors.kAccentColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildZimDots() {
    Widget result;
    switch(_zimType){
      case ZimType.WEALTH:
        result =DotsIndicator(
            decorator: DotsDecorator(
              activeColor: AppColors.kPrimaryColor,
                size: Size.fromRadius(3), activeSize: Size.fromRadius(3)),
            dotsCount:_wealthOptions.length,
            position: currentIndexPage);
        break;
      case ZimType.ASPIRE:
        result =DotsIndicator(
            decorator: DotsDecorator(
                activeColor: AppColors.kPrimaryColor,
                size: Size.fromRadius(3), activeSize: Size.fromRadius(3)),
            dotsCount:_aspireOptions.length,
            position: currentIndexPage);
        break;
      case ZimType.MUTUAL:
        return SizedBox();
        break;
    }
    return DotsIndicator(
        decorator: DotsDecorator(
            activeColor: AppColors.kPrimaryColor,
            size: Size.fromRadius(3), activeSize: Size.fromRadius(3)),
        dotsCount: _zimType == ZimType.WEALTH
            ? _wealthOptions.length
            : _aspireOptions.length,
        position: currentIndexPage);
  }

  Widget _buildZimSelectedDetails() {
    Widget result;
    switch (_zimType) {
      case ZimType.WEALTH:
        result = PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: [
            ZimCategoryWidget(amount: amount),
            ZimCategoryWidget(amount: amount),
            ZimAspireCategoryWidget(
              amount: amount,
              completion: 30,
            ),
          ],
        );
        break;
      case ZimType.ASPIRE:
        result = PageView(
          controller: aspireController,
          scrollDirection: Axis.horizontal,
          children: [
            ZimAspireCategoryWidget(
              amount: amount,
              completion: 30,
            ),
            ZimCategoryWidget(amount: amount),
          ],
        );
        break;
      case ZimType.MUTUAL:
        result = Text("No plans yet");
        break;
    }
    return Container(height: 110, child: result);
  }

  Widget _buildZimSelector() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 50,
      decoration: BoxDecoration(
          border:
              Border(top: AppStyles.menuBorder, bottom: AppStyles.menuBorder)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            XMargin(10),
            ZimSelectedButton(
              title: "Zimvest Wealth Box",
              onTap: () {
                setState(() {
                  _zimType = ZimType.WEALTH;
                  currentIndexPage = 0;
                });
              },
              type: ZimType.WEALTH,
              selectedType: _zimType,
            ),
            ZimSelectedButton(
              title: "Zimvest Aspire",
              onTap: () {
                setState(() {
                  _zimType = ZimType.ASPIRE;
                  currentIndexPage = 0;
                });
              },
              type: ZimType.ASPIRE,
              selectedType: _zimType,
            ),
            ZimSelectedButton(
              title: "Zimvest Mutual",
              onTap: () {
                setState(() {
                  _zimType = ZimType.MUTUAL;
                  currentIndexPage = 0;
                });
              },
              type: ZimType.MUTUAL,
              selectedType: _zimType,
            ),
          ],
        ),
      ),
    );
  }
}

class ZimCategoryWidget extends StatelessWidget {
  const ZimCategoryWidget({
    Key key,
    @required this.amount,
  }) : super(key: key);

  final FlutterMoneyFormatter amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      height: 102,
      width: 320,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Zimvest wealth balance",
                    style: AppStyles.tinyTitle,
                  ),
                  YMargin(4),
                  Text(
                    amount.output.symbolOnLeft,
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 16,
                        fontFamily: "Caros-Bold"),
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: AppColors.kWhite,
              )
            ],
          ),
          YMargin(6),
          Row(
            children: [
              Spacer(),
              Text(
                "View details",
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.kAccentColor,
                    fontFamily: "Caros-Medium"),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: AppColors.kAccentColor,
              )
            ],
          ),
          Spacer(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Accrued Interest",
                    style: TextStyle(
                        fontSize: 8, color: AppColors.kLightTitleText),
                  ),
                  Text(
                    amount.output.symbolOnLeft,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Caros-Bold",
                        color: AppColors.kWhite),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Interest rate",
                  style:
                      TextStyle(color: AppColors.kLightTitleText, fontSize: 10),
                ),
              ),
              XMargin(5),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "9% P.A",
                  style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 12,
                      fontFamily: "Caros-Bold"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ZimAspireCategoryWidget extends StatelessWidget {
  final double completion;
  const ZimAspireCategoryWidget({
    Key key,
    @required this.amount,
    @required this.completion,
  }) : super(key: key);

  final FlutterMoneyFormatter amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      height: 122,
      width: 320,
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "House rent",
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 16,
                        fontFamily: "Caros-Bold"),
                  ),
                  YMargin(4),
                  Text(
                    "Since 25 march, 2020",
                    style: AppStyles.tinyTitle,
                  ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: AppColors.kWhite,
              )
            ],
          ),
          YMargin(7),
          Row(
            children: [
              Spacer(),
              Text(
                "View details",
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.kAccentColor,
                    fontFamily: "Caros-Medium"),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: AppColors.kAccentColor,
              )
            ],
          ),
          Spacer(),
          LinearProgressIndicator(
            backgroundColor: Color(0xFFfcf8ee),
            value: completion / 100,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.kAccentColor),
          ),
          Spacer(),
          Row(
            children: [
              Text(
                "Accrued Interest",
                style: TextStyle(fontSize: 8, color: AppColors.kLightTitleText),
              ),
              Text(
                "/ ${amount.output.symbolOnLeft}",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Caros-Bold",
                    color: AppColors.kWhite),
              ),
              Spacer(),
              Text(
                "${completion}% Complete",
                style:
                    TextStyle(color: AppColors.kLightTitleText, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NotificationIdentifier extends StatelessWidget {
  const NotificationIdentifier({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.3,
      width: 33.3,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kLightText.withOpacity(0.3),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.notifications,
              size: 18,
            ),
          ),
          Positioned(
            left: 10,
            right: 0,
            top: 10,
            child: Container(
              height: 6,
              width: 6,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: AppColors.kRed),
            ),
          )
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  const Progress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100),
      height: 200,
      child: Stack(
        children: [
          CircularProgress(
            value: 0.99,
            bg: AppColors.kLightText,
          ),
          CircularProgress(
            value: .625,
            bg: AppColors.kAccentColor,
          ),
          CircularProgress(
            value: .47,
          ),
        ],
      ),
    );
  }
}
