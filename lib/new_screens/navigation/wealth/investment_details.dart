import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/transaction_vm.dart';
import 'package:zimvest/new_screens/funding/top_up_screen.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/delete_wealthbox.dart';
import 'package:zimvest/widgets/navigation/wealth_activites.dart';
import 'package:zimvest/widgets/navigation/wealth_more.dart';
import 'package:zimvest/widgets/navigation/wealthbox_activity.dart';

class InvestmentDetailsScreen extends StatefulWidget {
  final String investmentName;
  final String investmentType;
  final String balance;
  final String annualReturns;
  final int transactionId;
  final int instrumentId;
  final bool isMatured;
  final double withDrawableBalance;

  const InvestmentDetailsScreen(
      {Key key,
      this.investmentName,
      this.investmentType,
      this.balance,
      this.annualReturns,
      this.transactionId,
      this.instrumentId,
      this.isMatured,
      this.withDrawableBalance})
      : super(key: key);
  static Route<dynamic> route(
      {String investmentName,
      String investmentType,
      String balance,
      String annualReturns,
      int transactionId,
      int instrumentId,
      double withDrawableBalance,
      bool isMatured}) {
    return MaterialPageRoute(
        builder: (_) => InvestmentDetailsScreen(
              investmentName: investmentName,
              investmentType: investmentType,
              balance: balance,
              annualReturns: annualReturns,
              transactionId: transactionId,
              instrumentId: instrumentId,
              isMatured: isMatured,
              withDrawableBalance: withDrawableBalance,
            ),
        settings:
            RouteSettings(name: InvestmentDetailsScreen().toStringShort()));
  }

  @override
  _InvestmentDetailsScreenState createState() =>
      _InvestmentDetailsScreenState();
}

class _InvestmentDetailsScreenState extends State<InvestmentDetailsScreen> {
  ABSPaymentViewModel paymentViewModel;
  @override
  Widget build(BuildContext context) {
    paymentViewModel = Provider.of(context);
    bool whichActivity = widget.investmentType.contains("Zimvest High Yield");
    return whichActivity
        ? ViewModelProvider<PortfolioViewModel>.withConsumer(
            onModelReady: (model) => model.getInvestmentActivities(
                name: widget.investmentType,
                transactionId: widget.transactionId,
                instrumentId: widget.instrumentId),
            viewModelBuilder: () => PortfolioViewModel(),
            builder: (context, model, _) => Scaffold(
              backgroundColor: AppColors.kWhite,
              appBar: AppBar(
                iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          XMargin(20),
                          Text(
                            "${widget.investmentName}",
                            style: TextStyle(
                                fontSize: 15, fontFamily: AppStrings.fontBold),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.more_horiz_rounded,
                              color: AppColors.kPrimaryColor,
                            ),
                            onPressed: () {
                              showModalBottomSheet<Null>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InvestmentMore(startdate: model.activities.dateJoined, maturitydate: model.activities.maturityDate,);
                                  },
                                  isScrollControlled: true);
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          children: [
                            Text(
                              "You invested in ${widget.investmentType}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.kPrimaryColor,
                                  fontFamily: AppStrings.fontMedium),
                            ),
                            Spacer(),
                            Icon(
                              Icons.navigate_next_rounded,
                              color: AppColors.kPrimaryColor,
                            )
                          ],
                        ),
                      ),
                      YMargin(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Balance",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kSecondaryText),
                            ),
                            YMargin(10),
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
                                  StringUtils(widget.balance
                                          .substring(1)
                                          .split(".")
                                          .first)
                                      .convertWithComma(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kSecondaryBoldText),
                                ),
                                XMargin(3),
                                Transform.translate(
                                  offset: Offset(0, -4),
                                  child: Text(
                                    ".${widget.balance.split(".").last.substring(0, 2)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppStrings.fontMedium,
                                        color: AppColors.kSecondaryBoldText),
                                  ),
                                ),
                              ],
                            ),
                            YMargin(25),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Accrued Interest",
                                      style: TextStyle(
                                          fontFamily: AppStrings.fontNormal,
                                          color: AppColors.kGreyText,
                                          fontSize: 11),
                                    ),
                                    YMargin(4),
                                    Transform.translate(
                                      offset: Offset(-8, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_drop_up_outlined),
                                          Text(AppStrings.nairaSymbol, style: TextStyle(fontSize: 10,color: AppColors.kWealthDark, fontWeight: FontWeight.bold),),
                                          Text(
                                            "2,000",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppStrings.fontMedium,
                                                color: AppColors.kWealthDark,
                                                fontSize: 11),
                                          ),
                                          XMargin(5),
                                          Text(
                                            "Past 24h",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily:
                                                    AppStrings.fontNormal),
                                          ),
                                        ],
                                      ),
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
                                          fontFamily: AppStrings.fontNormal,
                                          color: AppColors.kGreyText,
                                          fontSize: 11),
                                    ),
                                    YMargin(4),
                                    Text(
                                      "${widget.annualReturns}",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: AppStrings.fontMedium,
                                          color: AppColors.kWealthDark),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      YMargin(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              paymentViewModel.availableAmount =
                                  model.activities.currentValue;
                              if (widget.isMatured) {
                                Navigator.of(context).push(
                                    WithdrawWealthScreen.route(
                                        name: widget.investmentName,
                                        withDrawable:
                                            widget.withDrawableBalance,
                                        transactionId: widget.transactionId,
                                        instrumentId: widget.instrumentId));
                              } else {
                                showModalBottomSheet<Null>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmAssetLiquidation(
                                        withDrawable:
                                            widget.withDrawableBalance,
                                        transactionId: widget.transactionId,
                                        instrumentId: widget.instrumentId,
                                        name: widget.investmentName);
                                  },
                                  isScrollControlled: true,
                                );
                              }
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColorLight,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/new/withdraw1.svg",
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  YMargin(12),
                                  Text(
                                    "Liquidate",
                                    style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 12,
                                        fontFamily: AppStrings.fontNormal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      YMargin(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Activities",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppStrings.fontMedium,
                                  color: AppColors.kGreyText),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet<Null>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return InvestmentActivities(transactionData: model.activities.transactionData,);
                                    },
                                    isScrollControlled: true);
                              },
                              child: Text("See all",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kPrimaryColor)),
                            ),
                          ],
                        ),
                      ),
                      YMargin(10),
                      model.busy
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 400,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                                  margin:
                                                      EdgeInsets.only(top: 10),
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
                                    itemCount: 3,
                                  ),
                                ),
                              ),
                            )
                          : model.activities.transactionData.length == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 120.0),
                                  child: Center(
                                    child: Text("No Activities Yet"),
                                  ),
                                )
                              : model.activities.transactionData == null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(top: 120.0),
                                      child: Center(
                                        child: Text("No Activities Yet"),
                                      ),
                                    )
                                  : Container(
                                      height: screenHeight(context),
                                      width: screenWidth(context),
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            InvestmentActivity(
                                          productTransaction: model.activities
                                              .transactionData[index],
                                        ),
                                        itemCount: model
                                            .activities.transactionData.length,
                                      ),
                                    ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : ViewModelProvider<PortfolioViewModel>.withConsumer(
            onModelReady: (model) => model.getFixedInvestmentActivities(
                name: widget.investmentType,
                transactionId: widget.transactionId,
                instrumentId: widget.instrumentId),
            viewModelBuilder: () => PortfolioViewModel(),
            builder: (context, model, _) => Scaffold(
              backgroundColor: AppColors.kWhite,
              appBar: AppBar(
                iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          XMargin(20),
                          Text(
                            "${widget.investmentName}",
                            style: TextStyle(
                                fontSize: 15, fontFamily: AppStrings.fontBold),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.more_horiz_rounded,
                              color: AppColors.kPrimaryColor,
                            ),
                            onPressed: () {
                              showModalBottomSheet<Null>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InvestmentMore(startdate: model.activities.dateJoined, maturitydate: model.activities.maturityDate,);
                                  },
                                  isScrollControlled: true);
                            },
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          children: [
                            Text(
                              "You invested in ${widget.investmentType}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.kPrimaryColor,
                                  fontFamily: AppStrings.fontMedium),
                            ),
                            Spacer(),
                            Icon(
                              Icons.navigate_next_rounded,
                              color: AppColors.kPrimaryColor,
                            )
                          ],
                        ),
                      ),
                      YMargin(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Balance",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kSecondaryText),
                            ),
                            YMargin(10),
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
                                  StringUtils(widget.balance
                                          .substring(1)
                                          .split(".")
                                          .first)
                                      .convertWithComma(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kSecondaryBoldText),
                                ),
                                XMargin(3),
                                Transform.translate(
                                  offset: Offset(0, -4),
                                  child: Text(
                                    ".${widget.balance.split(".").last.substring(0, 2)}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppStrings.fontMedium,
                                        color: AppColors.kSecondaryBoldText),
                                  ),
                                ),
                              ],
                            ),
                            YMargin(25),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Accrued Interest",
                                      style: TextStyle(
                                          fontFamily: AppStrings.fontNormal,
                                          color: AppColors.kGreyText,
                                          fontSize: 11),
                                    ),
                                    YMargin(4),
                                    Transform.translate(
                                      offset: Offset(-8, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_drop_up_outlined),
                                          Text(
                                            "${AppStrings.nairaSymbol}2,000",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppStrings.fontMedium,
                                                color: AppColors.kWealthDark,
                                                fontSize: 11),
                                          ),
                                          XMargin(5),
                                          Text(
                                            "Past 24h",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontFamily:
                                                    AppStrings.fontNormal),
                                          ),
                                        ],
                                      ),
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
                                          fontFamily: AppStrings.fontNormal,
                                          color: AppColors.kGreyText,
                                          fontSize: 11),
                                    ),
                                    YMargin(4),
                                    Text(
                                      "${widget.annualReturns}",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: AppStrings.fontMedium,
                                          color: AppColors.kWealthDark),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      YMargin(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              paymentViewModel.availableAmount =
                                  model.activities.currentValue;
                              if (widget.isMatured) {
                                Navigator.of(context).push(
                                    WithdrawWealthScreen.route(
                                        name: widget.investmentName,
                                        withDrawable:
                                            widget.withDrawableBalance,
                                        transactionId: widget.transactionId,
                                        instrumentId: widget.instrumentId));
                              } else {
                                showModalBottomSheet<Null>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmAssetLiquidation(
                                        withDrawable:
                                            widget.withDrawableBalance,
                                        transactionId: widget.transactionId,
                                        instrumentId: widget.instrumentId,
                                        name: widget.investmentName);
                                  },
                                  isScrollControlled: true,
                                );
                              }
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColorLight,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/new/withdraw1.svg",
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  YMargin(12),
                                  Text(
                                    "Liquidate",
                                    style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 12,
                                        fontFamily: AppStrings.fontNormal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      YMargin(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Activities",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppStrings.fontMedium,
                                  color: AppColors.kGreyText),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet<Null>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return InvestmentActivities(transactionData: model.activities.transactionData,);
                                    },
                                    isScrollControlled: true);
                              },
                              child: Text("See all",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: AppStrings.fontMedium,
                                      color: AppColors.kPrimaryColor)),
                            ),
                          ],
                        ),
                      ),
                      YMargin(10),
                      model.busy
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 400,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                                                  margin:
                                                      EdgeInsets.only(top: 10),
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
                                    itemCount: 3,
                                  ),
                                ),
                              ),
                            )
                          : model.activities.transactionData.length == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 120.0),
                                  child: Center(
                                    child: Text("No Activities Yet"),
                                  ),
                                )
                              : model.activities.transactionData == null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(top: 120.0),
                                      child: Center(
                                        child: Text("No Activities Yet"),
                                      ),
                                    )
                                  : Container(
                                      height: screenHeight(context),
                                      width: screenWidth(context),
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            InvestmentActivity(
                                          productTransaction: model.activities
                                              .transactionData[index],
                                        ),
                                        itemCount: model
                                            .activities.transactionData.length,
                                      ),
                                    ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class ConfirmAssetLiquidation extends StatelessWidget {
  const ConfirmAssetLiquidation({
    Key key,
    this.name,
    this.withDrawable,
    this.transactionId,
    this.instrumentId,
  }) : super(key: key);
  final String name;
  final double withDrawable;
  final int transactionId;
  final int instrumentId;
  @override
  Widget build(BuildContext context) {
    final buttonWidth = (MediaQuery.of(context).size.width - 110) / 2;
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          YMargin(10),
          Center(
            child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          YMargin(20),
          Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(20),
                    Text(
                      "Liquidate $name",
                      style:
                      TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
                    ),
                    YMargin(25),
                    Text(
                      "You would be charged 15% of your accrued interest for liquidating before investment maturity, 10% WHT Applies Would you like to proceed ?",
                      style: TextStyle(
                          fontSize: 11, height: 1.6, color: AppColors.kGreyText),
                    ),
                    YMargin(45),
                    Row(
                      children: [
                        PrimaryButtonNew(
                          textColor: AppColors.kPrimaryColor,
                          bg: AppColors.kPrimaryColorLight,
                          width: buttonWidth,
                          title: "No",
                          onTap: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                        XMargin(
                          20,
                        ),
                        PrimaryButtonNew(
                          onTap: () {
                            Navigator.of(context).push(
                              WithdrawWealthScreen.route(
                                  name: name,
                                  withDrawable: withDrawable,
                                  transactionId: transactionId,
                                  instrumentId: instrumentId),
                            );
                          },
                          textColor: AppColors.kWhite,
                          bg: AppColors.kPrimaryColor,
                          width: buttonWidth,
                          title: "Yes",
                        )
                      ],
                    )
                  ],
                ),
              )),
          YMargin(30)
        ],
      ),
    );
  }
}
