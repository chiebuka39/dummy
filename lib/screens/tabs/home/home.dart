import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';



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
import 'package:zimvest/widgets/home/graph_widgets.dart';
import 'package:zimvest/widgets/home/header_widgets.dart';
import 'package:zimvest/widgets/home/section_widgets.dart';



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
    print("ffff ${identityViewModel.user.expires.toIso8601String()}");

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
                        YMargin(30),
                        GestureDetector(
                          onTap: (){
                            showCupertinoModalBottomSheet(context: context, builder: (context){
                              return GraphsWidget(dashboardViewModel: dashboardViewModel);
                            });
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.kLightTitleText,width: 0.25),
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.kWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kLightTitleText.withOpacity(0.08),
                                  blurRadius: 4,
                                  offset: Offset(0,2)
                                )
                              ]
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            child: Row(children: [
                                SvgPicture.asset("images/port.svg"),
                              XMargin(20),
                              Text("View your portfolio distribution")
                            ],),
                          ),
                        ),
                        YMargin(20),
                        SectionWidgets(content: AppStrings.wealthBox,),
                        YMargin(20),
                        SectionWidgets(
                          img: 'aspire_img',
                          title: "Save with Zimvest Aspire",
                          content: AppStrings.aspireContent,),
                        YMargin(20),
                        SectionWidgets(
                          bgColor: AppColors.kInstruments,
                          img: 'yield_img',
                          title: "Invest with Zimvest High yield",
                          content: AppStrings.yieldContent,),
                        YMargin(20),
                        SectionWidgets(
                          bgColor: AppColors.kInstruments,
                          img: 'fixed_img',
                          title: "Invest in Zimvest Fixed Income",
                          content: AppStrings.fixedContent,),
                        YMargin(100),
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
