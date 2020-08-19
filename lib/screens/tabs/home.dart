import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



import 'package:provider/provider.dart';
import 'package:sa_multi_tween/sa_multi_tween.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
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
import 'package:supercharged/supercharged.dart';



enum AniProps { offset, opacity }

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AfterLayoutMixin<DashboardScreen> {
  ABSIdentityViewModel identityViewModel;
  ABSDashboardViewModel dashboardViewModel;
  ABSPaymentViewModel paymentViewModel;
  ABSSavingViewModel savingViewModel;
  ABSInvestmentViewModel investmentViewModel;

  PageController controller;
  PageController secondController;
  PageController thirdController;
  PageController aspireController;
  PageController headerController;
  List<String> _wealthOptions;
  List<String> _aspireOptions;
  List<String> _mutualOptions;

  double currentIndexPage = 0;

  ZimType2 _zimType;

  @override
  void initState() {
    controller = PageController(initialPage: 0, viewportFraction: 0.90);
    aspireController = PageController(initialPage: 0, viewportFraction: 0.90);
    secondController = PageController(initialPage: 0, viewportFraction: 0.90);
    thirdController = PageController();
    headerController = PageController();

    _zimType = ZimType2.ZIM_HIGH;
    _aspireOptions = ["", ""];
    _wealthOptions = ["", "", ""];
    _mutualOptions = ["", ""];

    controller.addListener(() {
      setState(() {
        currentIndexPage = controller.page;
      });
    });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    await dashboardViewModel.getPortfolioValue(identityViewModel.user.token);
    var r1 = await investmentViewModel.getTermFundValuation(token: identityViewModel.user.token);
    EasyLoading.dismiss();
    var r2 = await investmentViewModel.getFixedFundValuation(token: identityViewModel.user.token);
    var r3 = await savingViewModel.getSavingPlans(token: identityViewModel.user.token);

    await dashboardViewModel.getAssetDistribution(identityViewModel.user.token);
    await dashboardViewModel.getPortfolioDistribution(identityViewModel.user.token);
  }

  final _tween = MultiTween<AniProps>()
    ..add(AniProps.opacity, 0.0.tweenTo(1.0), 300.milliseconds)
    ..add(
      // top left => top right
        AniProps.offset,
        Tween(begin: Offset(0, 0), end: Offset(0, -20)),
        300.milliseconds, Curves.easeInOutSine);

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    investmentViewModel = Provider.of(context);
    print("ffff ${identityViewModel.user.token}");
    return PlayAnimation<MultiTweenValues<AniProps>>(
      tween: _tween,
      duration: _tween.duration,
      builder: (context, child, value){
        return Column(
          children: [
            Container(
              height: 255,
              child: PageView(
                controller: headerController,
                children: [
                  HeaderPage(
                    showLastWidget: false,
                    amount: dashboardViewModel.dashboardModel.totalPortfolio,
                    moveToNext: () {
                      headerController.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    title: "Total Portfolio balance",

                    bg: "header_bg",
                  ),
                  HeaderPage(
                    amount: dashboardViewModel.dashboardModel.dollarPortfolio,
                    moveToPrev: () {
                      headerController.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    moveToNext: (){
                      headerController.animateToPage(2,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  ),
                  HeaderPage(
                    amount: dashboardViewModel.dashboardModel.nairaPortfolio,
                    moveToPrev: () {
                      headerController.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    moveToNext: (){
                      headerController.animateToPage(3,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                    title: "My Naira portfolio balance",
                  ),
                  HeaderPage(

                    amount: dashboardViewModel.dashboardModel.totalPortfolio,
                    moveToPrev: () {
                      headerController.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    title: "My wallet balance",
                  ),
                ],
              ),
            ),
            investmentViewModel.termFunds == null ? Expanded(
              child: Container(
                color: Colors.white,
              ),
            ):Expanded(
              child: Transform.translate(
                offset: value.get(AniProps.offset),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kLightBG,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(16))),
                  child: Opacity(
                    opacity: value.get(AniProps.opacity),
                    child: ListView(
                      padding: EdgeInsets.only(top: 5),
                      children: [
                        _buildZimSelector(),
                        YMargin(5),
                        _buildZimSelectedDetails(),
                        YMargin(6),
                        _buildZimDots(),
                        YMargin(20),
                        StatsWidget(thirdController: thirdController),
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
              ),
            )
          ],
        );
      },
    );
  }

  Widget _buildZimDots() {
    Widget result;
    print("kk ${investmentViewModel.termFunds.length}");
    switch (_zimType) {
      case ZimType2.ZIM_HIGH:
        if(investmentViewModel.termFunds.isEmpty){
          result = SizedBox();
        }else{
          result = DotsIndicator(
              decorator: DotsDecorator(
                  activeColor: AppColors.kPrimaryColor,
                  size: Size.fromRadius(3),
                  activeSize: Size.fromRadius(3)),
              dotsCount: investmentViewModel.termFunds.length,
              position: currentIndexPage);
        }

        break;
      case ZimType2.ZIM_FIXED:
        if(investmentViewModel.fixedFunds.isEmpty){
          result = SizedBox();
        }else{
          result = DotsIndicator(
              decorator: DotsDecorator(
                  activeColor: AppColors.kPrimaryColor,
                  size: Size.fromRadius(3),
                  activeSize: Size.fromRadius(3)),
              dotsCount: investmentViewModel.fixedFunds.length,
              position: currentIndexPage);
        }

        break;
      case ZimType2.SAVINGS:
        if(savingViewModel.savingPlanModel.isEmpty){
          result = SizedBox();
        }else{
          result =  DotsIndicator(
              decorator: DotsDecorator(
                  activeColor: AppColors.kPrimaryColor,
                  size: Size.fromRadius(3),
                  activeSize: Size.fromRadius(3)),
              dotsCount: savingViewModel.savingPlanModel.length,
              position: currentIndexPage);
        }

        break;
    }
    return result;
  }

  Widget _buildZimSelectedDetails() {
    Widget result;
    switch (_zimType) {
      case ZimType2.ZIM_HIGH:
        if(investmentViewModel.termFunds.isEmpty){
          result =  SizedBox(child: Text("No items found"),);
        }else{
          result = PageView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: investmentViewModel.termFunds.map((e)
            => ZimCategoryWidget(amount: e.currentValue,
              title: e.termInstrumentName,rate: e.percentageInterest,),).toList(),
          );
        }
        break;
      case ZimType2.ZIM_FIXED:
        if(investmentViewModel.fixedFunds.isEmpty){
          result =  SizedBox(child: Text("No items found"),);
        }else{
          result = PageView(
            controller: aspireController,
            scrollDirection: Axis.horizontal,
            children: investmentViewModel.fixedFunds.map((e)
            => ZimCategoryWidget(amount: e.currentValue,
              title: e.fixedIncomeName,rate: e.percentageInterest,),).toList(),
          );
        }

        break;
      case ZimType2.SAVINGS:
        if(savingViewModel.savingPlanModel.isEmpty){
          result =  SizedBox(child: Text("No items found"),);
        }else{
          result = PageView(
            controller: aspireController,
            scrollDirection: Axis.horizontal,
            children: savingViewModel.savingPlanModel.map((e)
            => ZimCategoryWidget(amount: e.targetAmount.toString(),
              title: e.planName,rate: "9%",),).toList(),
          );
        }
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
              title: "Zimvest High yield",
              onTap: () {
                setState(() {
                  _zimType = ZimType2.ZIM_HIGH;
                  currentIndexPage = 0;
                });
              },
              type: ZimType2.ZIM_HIGH,
              selectedType: _zimType,
            ),
            ZimSelectedButton(
              title: "Zimvest Fixed Income",
              onTap: () async{
                  setState(() {
                    _zimType = ZimType2.ZIM_FIXED;
                    currentIndexPage = 0;
                  });


              },
              type: ZimType2.ZIM_FIXED,
              selectedType: _zimType,
            ),
            ZimSelectedButton(
              title: "Zimvest Savings",
              onTap: () async{

                  setState(() {
                    _zimType = ZimType2.SAVINGS;
                    currentIndexPage = 0;
                  });



              },
              type: ZimType2.SAVINGS,
              selectedType: _zimType,
            ),
          ],
        ),
      ),
    );
  }
}

class StatsWidget extends StatelessWidget {
  const StatsWidget({
    Key key,
    @required this.thirdController,
  }) : super(key: key);

  final PageController thirdController;

  @override
  Widget build(BuildContext context) {
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    //print("llll ${dashboardViewModel.assetDistribution.model.length}");
    return Container(
      height: 200,
      width: double.infinity,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: thirdController,
        children: [
          _buildDonut(dashboardViewModel),
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
    );
  }

  Row _buildDonut(ABSDashboardViewModel dashboardViewModel) {
    return Row(
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
                child: dashboardViewModel.portfolioDistribution.where(
                        (element) => element.percentageShare > 0).length > 0 ?
                DonutPieChart.withSampleData(dashboardViewModel.portfolioDistribution):Container(
                  child: Center(child: Image.asset("images/no_portfolio.png", height: 150,),),
                )),
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
        );
  }
}

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    Key key,
    @required this.amount,
    this.moveToPrev,
    this.moveToNext,
    this.title = "My Dollar portfolio balance", this.bg = "layer_2", this.showLastWidget = true,
  }) : super(key: key);


  final String amount;
  final VoidCallback moveToPrev;
  final VoidCallback moveToNext;
  final String title;
  final String bg;
  final bool showLastWidget;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: double.infinity,
      decoration: BoxDecoration(color: bg == "header_bg"?AppColors.kAccentColor: AppColors.kPrimaryColor),
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Image.asset(
                "images/$bg.png",
                width: double.infinity,
              )),
          SafeArea(
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
                        color: Colors.white.withOpacity(moveToPrev ==null ? 0:0.5),
                        size: 18,
                      ),
                      onPressed: moveToPrev,
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: bg == "header_bg"?AppColors.kPrimaryColor2: AppColors.kLightTitleText, fontSize: 13),
                        ),
                        YMargin(5),
                        Text(
                          amount,
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
                        color: Colors.white.withOpacity(moveToNext == null ?0:0.5),
                        size: 18,
                      ),
                      onPressed: moveToNext,
                    ),
                  ],
                ),
                YMargin(15),
                showLastWidget == true? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Accrued Interest",
                        style: AppStyles.tinyTitle,
                      ),
                      XMargin(10),
                      Text(
                        amount,
                        style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 12,
                            fontFamily: "Caros-Bold"),
                      ),
                    ],
                  ),
                ):SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ZimCategoryWidget extends StatelessWidget {
  const ZimCategoryWidget({
    Key key,
    @required this.amount, this.title ="", this.rate ="",
  }) : super(key: key);

  final String amount;
  final String title;
  final String rate;

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
                    title,
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
                    amount,
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

  final String amount;

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
                "/ $amount",
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
