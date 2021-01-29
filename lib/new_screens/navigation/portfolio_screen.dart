import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/data/view_models/dashboard_view_model.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/data/view_models/transaction_vm.dart';
import 'package:zimvest/new_screens/navigation/portfolio/aspire_widgets.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/select_goals.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire_box_details.dart';
import 'package:zimvest/new_screens/navigation/wealth/investment_details.dart';
import 'package:zimvest/new_screens/navigation/widgets/earn_free_cash.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/new_screens/navigation/wealth/wealth_box_details.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/home/action_box_widgets.dart';
import 'package:zimvest/widgets/navigation/wealthbox_detail_widget.dart';
import 'package:zimvest/widgets/new/loading.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  bool showInvest = false;

  @override
  Widget build(BuildContext context) {
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Portfolio",
                      style: TextStyle(
                          fontSize: 16, fontFamily: AppStrings.fontBold),
                    ),
                    Spacer(),
                    EarnFreeCashWidget()
                  ],
                ),
              ),
              YMargin(33),
              Row(
                children: <Widget>[
                  Spacer(),
                  Container(
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
                                  "Savings",
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
                                  "Investment",
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
                  Spacer(),
                ],
              ),
              YMargin(30),
            ])),
            showInvest ? PortfolioInvestmentWidget() : SavingsSection(),
          ],
        ),
      ),
    );
  }
}

class SavingsSection extends StatefulWidget {
  const SavingsSection({
    Key key,
  }) : super(key: key);

  @override
  _SavingsSectionState createState() => _SavingsSectionState();
}

class _SavingsSectionState extends State<SavingsSection>
    with AfterLayoutMixin<SavingsSection> {
  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  SavingPlanModel wealthBox;
  List<SavingPlanModel> aspirePlans = <SavingPlanModel>[];
  double totalBalance = 0;

  bool loading = false;

  bool error = false;
  bool networkAvailable = true;
  String errorMessage;

  @override
  void afterFirstLayout(BuildContext context) async {
    await getSavings();
  }

  Future getSavings() async {
    setState(() {
      loading = true;
      error = false;
    });

    var r1 = await savingViewModel.getSavingPlans(
        token: identityViewModel.user.token);
    var r2 = await savingViewModel.getProductTypes(
        token: identityViewModel.user.token);
    if (r1.error == false && r2.error == false) {
      totalBalance = 0;
      wealthBox = savingViewModel.savingPlanModel
              .where((element) => element.productId == 1)
              .isNotEmpty
          ? savingViewModel.savingPlanModel
              .where((element) => element.productId == 1)
              .first
          : null;
      aspirePlans = savingViewModel.savingPlanModel
          .where((element) => element.productId == 2)
          .toList();
      savingViewModel.savingPlanModel.forEach((element) {
        totalBalance = totalBalance + element.amountSaved;
      });

      setState(() {
        loading = false;
        error = false;
      });

      if (savingViewModel.productTypes.isNotEmpty) {
        await fetchTransactions(savingViewModel.productTypes.first.id);
      }

      //getRequiredDetailsForForm();
    } else {
      setState(() {
        loading = false;
        error = true;
        networkAvailable = r1.networkAvailable;
        errorMessage = r1.errorMessage;
      });
    }
  }

  Future<void> fetchTransactions(int productId,
      {bool showLoader = false}) async {
    if (showLoader == true) {
      await savingViewModel.getTransactionForProductType(
          token: identityViewModel.user.token, productId: productId);
    } else {
      var result = await savingViewModel.getTransactionForProductType(
          token: identityViewModel.user.token, productId: productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return error == true
        ? SavingsInvestmentErrorWidget(
            retry: getSavings,
            networkAvailable: networkAvailable,
            message: errorMessage,
          )
        : loading == true
            ? SavingsInvestmentLoadingWidget()
            : wealthBox == null && aspirePlans.isEmpty
                ? SavingsInvestmentWidget()
                : SavingsInvestmentCashWidget(
                    wealthBox: wealthBox,
                    aspirePlans: aspirePlans,
                    totalBalance: totalBalance,
                  );
  }
}

class SavingsInvestmentWidget extends StatelessWidget {
  const SavingsInvestmentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        YMargin(MediaQuery.of(context).size.height > 700 ? 200 : 100),
        SvgPicture.asset("images/new/savings_illus.svg"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200,
                child: Text(
                  "You currently don’t have a savings plan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kGreyText,
                      height: 1.6),
                )),
          ],
        ),
        YMargin(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonNew(
              title: "Start Saving",
              onTap: () {
                dashboardViewModel.callback();
              },
            ),
          ],
        ),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class SavingsInvestmentLoadingWidget extends StatelessWidget {
  const SavingsInvestmentLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        Container(
          height: 400,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: Shimmer.fromColors(
                          baseColor: Colors.red,
                          highlightColor: Colors.yellow,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              itemCount: 4,
            ),
          ),
        )
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class SavingsInvestmentErrorWidget extends StatelessWidget {
  const SavingsInvestmentErrorWidget({
    Key key,
    this.retry,
    this.networkAvailable,
    this.message,
  }) : super(key: key);

  final VoidCallback retry;
  final bool networkAvailable;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        NoInternetWidget2(message: message ?? "Something went wrong", retry: retry)
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class NoInternetWidget2 extends StatelessWidget {
  const NoInternetWidget2({
    Key key,
    @required this.message,
    @required this.retry,
  }) : super(key: key);

  final String message;
  final VoidCallback retry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          YMargin(30),
          SvgPicture.asset("images/new/error3.svg"),
          YMargin(20),
          SizedBox(
              width: 300,
              child: Text(
                message,
                style: TextStyle(
                    fontFamily: AppStrings.fontNormal, height: 1.7),
                textAlign: TextAlign.center,
              )),
          YMargin(30),
          PrimaryButtonNew(
            title: 'Retry',
            onTap: retry,
          )
        ],
      ),
    );
  }
}

class SavingsInvestmentCashWidget extends StatelessWidget {
  const SavingsInvestmentCashWidget({
    Key key,
    this.wealthBox,
    this.aspirePlans,
    this.totalBalance,
  }) : super(key: key);

  final SavingPlanModel wealthBox;
  final double totalBalance;
  final List<SavingPlanModel> aspirePlans;

  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    ABSDashboardViewModel dashboardViewModel = Provider.of(context);
    List<SavingPlanModel> goals = [...savingViewModel.savingPlanModel.where((element) => element.productId == 2), SavingPlanModel()];
    List<SavingPlanModel> goals1 = [...savingViewModel.savingPlanModel.where((element) => element.productId == 2), SavingPlanModel()];
    print("ooo<<<<<<<<<<<<<<<<<");

    return SliverPadding(
      sliver: SliverList(
          delegate: SliverChildListDelegate([
        Text(
          "Total balance",
          style: TextStyle(
              color: AppColors.kGreyText, fontFamily: AppStrings.fontMedium),
        ),
        YMargin(12),
        Row(
          children: [
            Transform.translate(
                offset: Offset(0, -4),
                child: Text(
                  AppStrings.nairaSymbol,
                  style: TextStyle(
                      fontSize: 14, color: AppColors.kSecondaryBoldText),
                )),
            XMargin(2),
            Text(
              dashboardViewModel.dashboardModel.nairaPortfolio == "0.00" ? '0':dashboardViewModel.dashboardModel.nairaSavings
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
                ".${dashboardViewModel.dashboardModel.nairaSavings.split(".").last}",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppStrings.fontMedium,
                    color: AppColors.kSecondaryBoldText),
              ),
            ),
          ],
        ),
        YMargin(25),
            savingViewModel.savingPlanModel.where((element) => element.productId == 1).length == 0
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, WealthBoxDetailsScreen.route(wealthBox));
                },
                child: Container(
                  height: 154,
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    boxShadow: AppUtils.getBoxShaddow,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YMargin(3),
                      Text(wealthBox.planName),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Balance",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: AppColors.kGreyText),
                              ),
                              YMargin(10),
                              Row(
                                children: [
                                  Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 12),),
                                  Text(
                                    "${wealthBox.amountSaved}".split(".").first.convertWithComma(),
                                    style: TextStyle(
                                        color: AppColors.kGreyText,
                                        fontFamily: AppStrings.fontMedium),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Interest P.A",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppStrings.fontNormal,
                                    color: AppColors.kGreyText),
                              ),
                              YMargin(10),
                              Text(
                                "${wealthBox.interestRate}%",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.kGreyText,
                                    fontFamily: AppStrings.fontMedium),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
        Row(
          children: [
            Text(
              "Goals",
              style: TextStyle(
                  fontFamily: AppStrings.fontMedium,
                  color: AppColors.kGreyText),
            ),
            XMargin(3),
            Text(
              "(Zimvest aspire)",
              style: TextStyle(
                  fontFamily: AppStrings.fontNormal,
                  color: AppColors.kGreyText,
                  fontSize: 12),
            ),
          ],
        ),
        ...List.generate((goals.length / 2).round(), (index) {
          print("ppmm ${index} >>>> ${(goals.length / 2).round() - 1}");
          if (goals.length.isOdd && ((goals.length / 2).round() - 1) == index) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  buildNewGoal(),
                  XMargin(20),
                  Expanded(
                    child: Opacity(
                      opacity: 0,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        height: 154,
                        decoration: BoxDecoration(
                            color: AppColors.kGreyBg,
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (goals.length.isEven &&
              ((goals.length / 2).round() - 1) == index) {
            SavingPlanModel goal = goals1.removeAt(0);
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  AspireContainerWidget(
                    goal: goal,
                  ),
                  XMargin(20),
                  buildNewGoal(),
                ],
              ),
            );
          }
          SavingPlanModel goal1 = goals1.removeAt(0);
          SavingPlanModel goal2 = goals1.removeAt(0);
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                AspireContainerWidget(
                  goal: goal1,
                ),
                XMargin(20),
                AspireContainerWidget(
                  goal: goal2,
                ),
              ],
            ),
          );
        }),
        YMargin(70),
      ])),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget buildNewGoal() {
    return AspireNewGoalWidget();
  }

  Widget buildAspireContainer() {
    return AspireContainerWidget();
  }
}

class PortfolioInvestmentWidget extends StatefulWidget {
  const PortfolioInvestmentWidget({
    Key key,
  }) : super(key: key);

  @override
  _PortfolioInvestmentWidgetState createState() =>
      _PortfolioInvestmentWidgetState();
}

class _PortfolioInvestmentWidgetState extends State<PortfolioInvestmentWidget> {
  // bool naira = true;
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BaseViewModel>.withConsumer(
      viewModelBuilder: () => BaseViewModel(),
      builder: (context, model, _) => SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              YMargin(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  // setState(() {
                                  //   modelnaira = true;
                                  // });
                                  model.switcher();
                                },
                                child: Text(
                                  "Naira",
                                  style: TextStyle(
                                      color: model.swittch
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kTextColor,
                                      fontSize: 12,
                                      fontFamily: model.swittch
                                          ? AppStrings.fontMedium
                                          : AppStrings.fontNormal),
                                )),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                model.switcher();
                              },
                              child: Text(
                                "Dollar",
                                style: TextStyle(
                                    color: model.swittch
                                        ? AppColors.kTextColor
                                        : AppColors.kPrimaryColor,
                                    fontSize: 12,
                                    fontFamily: model.swittch
                                        ? AppStrings.fontNormal
                                        : AppStrings.fontMedium),
                              ),
                            ),
                          ],
                        ),
                        AnimatedPositioned(
                            top: 20,
                            left: model.swittch ? 5 : 70,
                            child: Container(
                              height: 3,
                              width: 20,
                              decoration:
                                  BoxDecoration(color: AppColors.kPrimaryColor),
                            ),
                            duration: Duration(milliseconds: 300))
                      ],
                    ),
                  )
                ],
              ),
              model.swittch ? nairaPortfolio(context) : dollarPortfolio(context)
            ],
          ),
        ),
      ),
    );
  }
}

class InvestmentItemWidget extends StatelessWidget {
  final String investmentName;
  final String investmentType;
  final String balance;
  final String annualReturns;
  final double topPadding;
  final int transactionId;
  final int instrumentId;
  final bool isMatured;
  final double withDrawableBalance;
  const InvestmentItemWidget({
    Key key,
    this.investmentName,
    this.investmentType,
    this.balance,
    this.annualReturns,
    this.topPadding = 25.0,
    this.transactionId,
    this.instrumentId,
    this.isMatured,
    this.withDrawableBalance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          InvestmentDetailsScreen.route(
            withDrawableBalance: withDrawableBalance,
            isMatured: isMatured,
            investmentName: investmentName,
            investmentType: investmentType,
            balance: balance,
            annualReturns: annualReturns,
            transactionId: transactionId,
            instrumentId: instrumentId,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: topPadding),
        padding: EdgeInsets.all(11),
        height: 154,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: AppUtils.getBoxShaddow,
            borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              investmentName,
              style: TextStyle(fontSize: 13, fontFamily: AppStrings.fontMedium),
            ),
            YMargin(8),
            Text(
              investmentType,
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.kTextColor,
                  fontFamily: AppStrings.fontLight),
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Row(
                      children: [
                        Text(
                          AppStrings.nairaSymbol,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontMedium,
                              color: AppColors.kTextColor),
                        ),
                        Text(
                          StringUtils(balance.substring(1).split(".").first)
                              .convertWithComma(),
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontMedium,
                              color: AppColors.kTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Annual Returns",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kTextColor),
                    ),
                    YMargin(8),
                    Text(
                      "$annualReturns%",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kWealthDark),
                    ),
                  ],
                )
              ],
            ),
            YMargin(8)
          ],
        ),
      ),
    );
  }
}

class EmptyInvstmentWidget extends StatefulWidget {
  const EmptyInvstmentWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyInvstmentWidgetState createState() => _EmptyInvstmentWidgetState();
}

class _EmptyInvstmentWidgetState extends State<EmptyInvstmentWidget>
    with AfterLayoutMixin<EmptyInvstmentWidget> {
  @override
  void afterFirstLayout(BuildContext context) {
    print("1111111111");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YMargin(MediaQuery.of(context).size.height > 700 ? 100 : 50),
        SvgPicture.asset(
          "images/new/empty3.svg",
        ),
        YMargin(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 200,
                child: Text(
                  "You currently don’t have an Investment plan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kGreyText,
                      height: 1.6),
                )),
          ],
        ),
        YMargin(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButtonNew(
              onTap: () {},
              title: "Start Investing",
            ),
          ],
        ),
      ],
    );
  }
}

Widget dollarPortfolio(BuildContext context) {
  ABSDashboardViewModel dashboardViewModel = Provider.of(context);
  return ViewModelProvider<PortfolioViewModel>.withConsumer(
    viewModelBuilder: () => PortfolioViewModel(),
    onModelReady: (model) => model.getDollarPortfolio(),
    builder: (context, model, _) => Container(
      height: screenHeight(context),
      width: screenWidth(context),
      child: model.busy
          ? Container(
              height: 400,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 200.0,
                            height: 50.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.yellow,
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 40.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  itemCount: 4,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kTextColor.withOpacity(0.4),
                  ),
                ),
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
                      dashboardViewModel.dashboardModel.dollarPortfolio ==
                              "0.00"
                          ? '0'
                          : dashboardViewModel.dashboardModel.dollarPortfolio
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
                        ".${dashboardViewModel.dashboardModel.dollarPortfolio.split(".").last}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: AppStrings.fontMedium,
                            color: AppColors.kSecondaryBoldText),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    padding: EdgeInsets.only(bottom: 155),
                    child: model.dollarTransaction.length == 0
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 150.0),
                              child: Text(
                                "No Transactons yet",
                                style: TextStyle(color: AppColors.kTextColor),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: model.dollarTransaction.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InvestmentItemWidget(
                                topPadding: 0,
                                investmentName:
                                    model.dollarTransaction[index].uniqueName,
                                investmentType: model.dollarTransaction[index]
                                    .zimvestInstrumentName,
                                balance:
                                    "${AppStrings.dollarSymbol}${model.dollarTransaction[index].withdrawableValue.toString()}",
                                annualReturns:
                                    "${model.dollarTransaction[index].percentageInterest.toString()}",
                              ),
                            ),
                          ),
                  ),
                ),
                YMargin(104),
              ],
            ),
    ),
  );
}

Widget nairaPortfolio(BuildContext context) {
  ABSDashboardViewModel dashboardViewModel = Provider.of(context);
  return ViewModelProvider<PortfolioViewModel>.withConsumer(
    viewModelBuilder: () => PortfolioViewModel(),
    onModelReady: (model) => model.getNairaPortfolio(),
    builder: (context, model, _) => Container(
      height: screenHeight(context),
      width: screenWidth(context),
      child: model.busy
          ? Container(
              height: 400,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 200.0,
                            height: 50.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.red,
                              highlightColor: Colors.yellow,
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 40.0,
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                  itemCount: 4,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kTextColor.withOpacity(0.4),
                  ),
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
                Expanded(
                  child: Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    padding: EdgeInsets.only(bottom: 155),
                    margin: EdgeInsets.only(bottom: 10),
                    child: model.nairaTransaction.length == 0
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 150.0),
                              child: Text(
                                "No Transactons yet",
                                style: TextStyle(color: AppColors.kTextColor),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: model.nairaTransaction.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InvestmentItemWidget(
                                withDrawableBalance: model
                                    .nairaTransaction[index].withdrawableValue,
                                isMatured:
                                    model.nairaTransaction[index].isMatured,
                                transactionId:
                                    model.nairaTransaction[index].transactionId,
                                instrumentId:
                                    model.nairaTransaction[index].instrumentId,
                                topPadding: 0,
                                investmentName:
                                    model.nairaTransaction[index].uniqueName,
                                investmentType: model
                                    .nairaTransaction[index].instrumentName,
                                balance:
                                    "${AppStrings.nairaSymbol}${model.nairaTransaction[index].withdrawableValue.toString() + "0"}",
                                annualReturns:
                                    "${model.nairaTransaction[index].percentageInterest.toString()}",
                              ),
                            ),
                          ),
                  ),
                ),
                YMargin(150),
              ],
            ),
    ),
  );
}
