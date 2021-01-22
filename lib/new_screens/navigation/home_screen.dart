import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timelines/timelines.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_screen.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_details_dollars.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_details_naira.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/investment_high_yield_naira.dart';
import 'package:zimvest/new_screens/navigation/investments/investment_high_yield_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/aspire_box_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/wealth_box_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/new_screens/navigation/wealth_screen.dart';
import 'package:zimvest/new_screens/navigation/widgets/earn_free_cash.dart';
import 'package:zimvest/new_screens/portfolio_breakdown/dollar_portfolio_breakdown.dart';
import 'package:zimvest/new_screens/portfolio_breakdown/naira_portfolio_breakdown.dart';
import 'package:zimvest/new_screens/profile/profile_screen.dart';
import 'package:zimvest/new_screens/profile/verification_details_screen.dart';
import 'package:zimvest/screens/wallet/fund_wallet.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback callback;

  const HomeScreen({Key key, this.callback}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();

  ABSIdentityViewModel identityViewModel;
  ABSDashboardViewModel dashboardViewModel;
  ABSSavingViewModel savingViewModel;
  ABSSettingsViewModel settingsViewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    dashboardViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
    settingsViewModel = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              YMargin(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(ProfileScreen.route());
                      },
                      child: Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.kGrey),
                          child: Center(
                              child: SvgPicture.asset("images/profile.svg"))),
                    ),
                    XMargin(10),
                    Text(
                      "Hi, ${identityViewModel.user.fullname.split(" ").first}",
                      style: TextStyle(fontFamily: AppStrings.fontMedium),
                    ),
                    Spacer(),
                    EarnFreeCashWidget()
                  ],
                ),
              ),
              Container(
                height: 165,
                child: PageView(
                  controller: controller,
                  children: [
                    Container(
                      height: 165,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Naira Portfolio",
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.kSecondaryText,
                                fontFamily: AppStrings.fontNormal),
                          ),
                          YMargin(12),
                          Row(
                            children: [
                              Transform.translate(
                                  offset: Offset(0, -4),
                                  child: Text(
                                    AppStrings.nairaSymbol,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.kSecondaryBoldText),
                                  )),
                              XMargin(2),
                              Text(
                                dashboardViewModel.dashboardModel.nairaPortfolio
                                    .substring(1)
                                    .split(".")
                                    .first,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kSecondaryBoldText),
                              ),
                              XMargin(3),
                              Transform.translate(
                                offset: Offset(0, -4),
                                child: Text(
                                  ".${dashboardViewModel.dashboardModel.nairaPortfolio.split(".").last}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kSecondaryBoldText),
                                ),
                              ),
                            ],
                          ),
                          YMargin(16),
                          Row(
                            children: [
                              Icon(Icons.arrow_drop_up_outlined,
                                  color: AppColors.kFixed),
                              Text(AppStrings.nairaSymbol,style: TextStyle(
                                  fontSize: 12,color: AppColors.kFixed)),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kFixed),
                              ),
                              XMargin(5),
                              Text(
                                "(0.00%)",
                                style: TextStyle(
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kFixed),
                              ),
                              XMargin(5),
                              Text(
                                "Past 24h",
                                style: TextStyle(),
                              ),
                              Spacer(),
                              Transform.translate(
                                offset: Offset(0, 2),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        NairaPortfolioBreakdownScreen.route());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Portfolio Breakdown",
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 11,
                                            fontFamily: AppStrings.fontNormal),
                                      ),
                                      Icon(
                                        Icons.navigate_next_rounded,
                                        color: AppColors.kPrimaryColor,
                                        size: 19,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 165,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dollar Portfolio",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.kSecondaryText,
                                  fontFamily: AppStrings.fontNormal)),
                          YMargin(12),
                          Row(
                            children: [
                              Transform.translate(
                                  offset: Offset(0, -4),
                                  child: Text(
                                    "\$",
                                    style: TextStyle(fontSize: 14),
                                  )),
                              XMargin(2),
                              Text(
                                 dashboardViewModel
                                    .dashboardModel.dollarPortfolio.substring(1)
                                    .split(".")
                                    .first,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kSecondaryBoldText),
                              ),
                              XMargin(3),
                              Transform.translate(
                                offset: Offset(0, -4),
                                child: Text(
                                  ".${dashboardViewModel.dashboardModel.dollarPortfolio.split(".").last}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kSecondaryBoldText),
                                ),
                              ),
                            ],
                          ),
                          YMargin(16),
                          Row(
                            children: [
                              Icon(Icons.arrow_drop_up_outlined,
                                  color: AppColors.kFixed),
                              Text("\$0",
                                  style: TextStyle(
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kFixed)),
                              XMargin(5),
                              Text(
                                "(0.00%)",
                                style: TextStyle(
                                    fontFamily: AppStrings.fontMedium,
                                    color: AppColors.kFixed),
                              ),
                              XMargin(5),
                              Text(
                                "Past 24h",
                                style: TextStyle(),
                              ),
                              Spacer(),
                              Transform.translate(
                                offset: Offset(0, 2),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        DollarPortfolioBreakdownScreen.route());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Portfolio Breakdown",
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 11,
                                            fontFamily: AppStrings.fontNormal),
                                      ),
                                      Icon(
                                        Icons.navigate_next_rounded,
                                        color: AppColors.kPrimaryColor,
                                        size: 19,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SmoothPageIndicator(
                  controller: controller, // PageController
                  count: 2,
                  effect: WormEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      dotColor: AppColors.kGreyBg,
                      activeDotColor:
                          AppColors.kPrimaryColor), // your preferred effect
                  onDotClicked: (index) {}),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Actions"),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: settingsViewModel.completedSections == null ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: settingsViewModel.completedSections == null
                    ? SizedBox(
                        height: 120,
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 120,
                        child: Timeline1(
                          actions: settingsViewModel.completedSections
                                      .kycValidationCheck.isKycValidated ==
                                  false
                              ? ['Verify Identity', 'Fund Wallet']
                              : ['Fund Wallet'],
                          callbacks: settingsViewModel.completedSections
                                      .kycValidationCheck.isKycValidated ==
                                  false
                              ? [
                                  () {
                                    Navigator.push(context,
                                        VerificationDetailsScreen.route());
                                  },
                                  () {
                                    widget.callback();
                                  }
                                ]
                              : [
                                  () {
                                    widget.callback();
                                  }
                                ],
                        )),
              ),
              ActionBoxWidget(
                title: "Save with Zimvest wealth box",
                desc: "This savings plan assists you save in a "
                    "disciplined manner.",
                color: AppColors.kWealth,
                onTap: () {
                  if (savingViewModel.savingPlanModel == null) {
                    Navigator.push(context, WealthBoxScreen.route());
                  } else if (savingViewModel.savingPlanModel
                      .where((element) => element.productId == 1)
                      .isEmpty) {
                    Navigator.push(context, WealthBoxScreen.route());
                  } else {
                    Navigator.push(
                        context,
                        WealthBoxDetailsScreen.route(savingViewModel
                            .savingPlanModel
                            .where((element) => element.productId == 1)
                            .first));
                  }
                },
              ),
              ActionBoxWidget(
                title: "Save with Zimvest Aspire",
                desc: "This savings plan allows you "
                    "save towards a goal. ",
                color: AppColors.kAspire,
                img: 'aspire',
                onTap: () {
                  Navigator.push(context, AspireSavingScreen.route());
                },
              ),
              ActionBoxWidget(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ViewModelProvider<
                        InvestmentHighYieldViewModel>.withConsumer(
                      viewModelBuilder: () => InvestmentHighYieldViewModel(),
                      builder: (context, model, _) => Container(
                        height: 400,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            YMargin(10),
                            Container(
                              height: 385,
                              width: double.infinity,
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
                                  YMargin(50),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      "Zimvest High Yield",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppStrings.fontNormal),
                                    ),
                                  ),
                                  YMargin(20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        HighYieldDetails.route(),
                                      ),
                                      child: Container(
                                        height: 130,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "Zimvest High Yield Naira",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.fontNormal,
                                                  color: AppColors.kWhite,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                height: 40,
                                                // width: 150,
                                                child: Text(
                                                  "Invest in our naira denominated fixed deposit product and watch you Naira grow.",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        AppStrings.fontNormal,
                                                    color: AppColors.kWhite,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  YMargin(20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                        context,
                                        HighYieldDetailsDollar.route(),
                                      ),
                                      child: Container(
                                        height: 130,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.kSecondaryColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "Zimvest High Yield Dollar",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.fontNormal,
                                                  color: AppColors.kWhite,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                height: 40,
                                                // width: 150,
                                                child: Text(
                                                  "Invest in our USD denominated fixed deposit and hedge against exchange rate risk, plus appreciable returns on your dollar investment.  ",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        AppStrings.fontNormal,
                                                    color: AppColors.kWhite,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                title: "Invest in Zimvest High Yield",
                desc: "This plan, which is similar to fixed"
                    "deposits run by banks, offers you"
                    "competitive interest rate.",
                color: AppColors.kHighYield,
                img: 'high',
              ),
              ActionBoxWidget(
                onTap: () => Navigator.push(
                  context,
                  FixedIncomeHome.route(),
                ),
                title: "Invest in Zimvest Fixed Income",
                desc:
                    "Invest in fixed income vehicles such as Treasury Bills, FGN Bonds, Corporate Bonds, and Eurobonds",
                color: AppColors.kFixed,
                img: 'fixed',
              ),
              YMargin(100)
            ],
          ),
        ),
      ),
    );
  }
}

class Timeline1 extends StatelessWidget {
  final List<String> actions;
  final List<VoidCallback> callbacks;

  const Timeline1({Key key, this.actions, this.callbacks}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xffd3d3d3),
        ),
        indicatorTheme: IndicatorThemeData(
          size: 15.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      builder: TimelineTileBuilder.connected(
        contentsBuilder: (_, index) => _EmptyContents(
          title: actions[index],
          onTap: callbacks[index],
        ),
        connectorBuilder: (_, index, __) {
          if (index == 0) {
            return SolidLineConnector(
              color: Color(0xffE9E9E9),
              thickness: 1,
            );
          } else {
            return SolidLineConnector();
          }
        },
        indicatorBuilder: (_, index) {
          return Container(
            width: 22,
            height: 22,
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border:
                        Border.all(color: AppColors.kPrimaryColor, width: 0.5)),
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                    color: AppColors.kPrimaryColor.withOpacity(0.2))),
          );
        },
        itemExtentBuilder: (_, __) => kTileHeight,
        itemCount: actions.length,
      ),
    );
  }
}

const kTileHeight = 50.0;

class _EmptyContents extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _EmptyContents({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.0),
        height: 30.0,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, fontFamily: AppStrings.fontNormal),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.kPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
