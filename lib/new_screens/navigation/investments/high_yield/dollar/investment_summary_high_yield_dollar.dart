import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/services/connectivity_service.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/terms_and_conditions_box.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/flushbar.dart';
import 'package:zimvest/widgets/new/anim.dart';

import '../../../../tabs.dart';
import 'dollar_investment_confirmation.dart';

class InvestmentSummaryScreenDollar extends StatefulWidget {
  final double amount;
  final int productId;
  final int channelId;
  final String uniqueName;
  final String duration;
  final String maturityDate;
  final String rate;
  final double minimumAmount;
  final String maximumAmount;
  final int walletType;

  const InvestmentSummaryScreenDollar(
      {Key key,
      this.amount,
      this.productId,
      this.channelId,
      this.uniqueName,
      this.duration,
      this.maturityDate,
      this.rate,
      this.minimumAmount,
      this.maximumAmount,
      this.walletType})
      : super(key: key);
  static Route<dynamic> route({
    double amount,
    int productId,
    int channelId,
    String uniqueName,
    String duration,
    String maturityDate,
    String rate,
    double minimumAmount,
    String maximumAmount,
    int walletType,
  }) {
    return MaterialPageRoute(
      builder: (_) => InvestmentSummaryScreenDollar(
        amount: amount,
        productId: productId,
        channelId: channelId,
        uniqueName: uniqueName,
        maturityDate: maturityDate,
        rate: rate,
        minimumAmount: minimumAmount,
        maximumAmount: maximumAmount,
        walletType: walletType,
      ),
      settings: RouteSettings(
        name: InvestmentSummaryScreenDollar().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentSummaryScreenDollarState createState() =>
      _InvestmentSummaryScreenDollarState();
}

class _InvestmentSummaryScreenDollarState
    extends State<InvestmentSummaryScreenDollar> {
  List<GlobalKey<ItemFaderState>> keys;

  bool loading = false;

  final _tween = MultiTween<AniProps>()
    ..add(
        AniProps.offset1,
        Tween(begin: Offset(0, 10), end: Offset(0, 0)),
        800.milliseconds,
        Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ))
    ..add(
        AniProps.scale,
        Tween(begin: 0.0, end: 1.0),
        800.milliseconds,
        Interval(
          0.0,
          0.6,
          curve: Curves.bounceInOut,
        ))
    ..add(
        AniProps.opacity1,
        0.0.tweenTo(1.0),
        800.milliseconds,
        Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ));

  bool confirmed = false;

  bool slideUp = false;

  @override
  void initState() {
    keys = List.generate(2, (index) => GlobalKey<ItemFaderState>());

    super.initState();
  }

  void startAnim() async {
    setState(() {
      slideUp = true;
      loading = true;
    });
  }

  void onInit() async {
    for (var key in keys) {
      key.currentState.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    ConnectionProvider network = Provider.of(context);
    ABSPaymentViewModel paymentViewModel = Provider.of(context);

    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.kSecondaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
             slideUp ? SvgPicture.asset("images/patterns.svg", fit: BoxFit.fill,): Container(),
              Positioned.fill(
                child: model.status
                    ? PlayAnimation<MultiTweenValues<AniProps>>(
                        tween: _tween,
                        duration: _tween.duration,
                        builder: (context, child, value) {
                          return Container(
                            // color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Spacer(
                                  flex: 2,
                                ),
                                Transform.scale(
                                  scale: value.get(AniProps.scale),
                                  child: Transform.translate(
                                    offset: value.get(AniProps.offset1),
                                    child: Opacity(
                                      opacity: value.get(AniProps.opacity1),
                                      child: Text(
                                        "Transaction Processing",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppStrings.fontMedium,
                                            color: AppColors.kWhite),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Transform.scale(
                                  scale: value.get(AniProps.scale),
                                  child: Transform.translate(
                                    offset: value.get(AniProps.offset1),
                                    child: Opacity(
                                      opacity: value.get(AniProps.opacity1),
                                      child: SvgPicture.asset(
                                          "images/new/confetti.svg"),
                                    ),
                                  ),
                                ),
                                YMargin(40),
                                Transform.scale(
                                  scale: value.get(AniProps.scale),
                                  child: Transform.translate(
                                    offset: value.get(AniProps.offset1),
                                    child: Opacity(
                                      opacity: slideUp
                                          ? value.get(AniProps.opacity1)
                                          : 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          "Transaction will be confirmed between 48 - 72 hours",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Transform.scale(
                                  scale: value.get(AniProps.scale),
                                  child: Transform.translate(
                                    offset: value.get(AniProps.offset1),
                                    child: Opacity(
                                      opacity: slideUp
                                          ? value.get(AniProps.opacity1)
                                          : 0.0,
                                      child: PrimaryButtonNew(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TabsContainer()),
                                              (Route<dynamic> route) => false);
                                        },
                                        textColor: Colors.white,
                                        title: "Done",
                                        bg: AppColors.kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                YMargin(50)
                              ],
                            ),
                          );
                        },
                      )
                    : model.busy
                        ? Center(child: LoadingWIdget())
                        : model.status
                            ? Text(
                                model.status.toString(),
                                style: TextStyle(color: AppColors.kWhite),
                              )
                            : PlayAnimation<MultiTweenValues<AniProps>>(
                                tween: _tween,
                                duration: _tween.duration,
                                builder: (context, child, value) {
                                  return Container(
                                    width: screenWidth(context),
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Transform.scale(
                                            scale: value.get(AniProps.scale),
                                            child: Transform.translate(
                                              offset:
                                                  value.get(AniProps.offset1),
                                              child: Opacity(
                                                opacity: value
                                                    .get(AniProps.opacity1),
                                                child: SvgPicture.asset(
                                                    "images/new/errfetti.svg"),
                                              ),
                                            ),
                                          ),
                                          YMargin(40),
                                          Transform.scale(
                                            scale: value.get(AniProps.scale),
                                            child: Transform.translate(
                                              offset:
                                                  value.get(AniProps.offset1),
                                              child: Opacity(
                                                opacity: slideUp
                                                    ? value
                                                        .get(AniProps.opacity1)
                                                    : 0.0,
                                                child: Text(
                                                  "Your investment was not successful",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Transform.scale(
                                            scale: value.get(AniProps.scale),
                                            child: Transform.translate(
                                              offset:
                                                  value.get(AniProps.offset1),
                                              child: Opacity(
                                                opacity: slideUp
                                                    ? value
                                                        .get(AniProps.opacity1)
                                                    : 0.0,
                                                child: PrimaryButtonNew(
                                                  onTap: () {
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TabsContainer()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                                  },
                                                  textColor: Colors.white,
                                                  title: "Retry",
                                                  bg: AppColors.kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          YMargin(50)
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: slideUp ? -(MediaQuery.of(context).size.height - 200) : 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      boxShadow: AppUtils.getBoxShaddow3),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackButton(
                              color: AppColors.kPrimaryColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: InkWell(
                                onTap: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabsContainer()),
                                    (Route<dynamic> route) => false),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontNormal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            // XMargin(1),
                          ],
                        ),
                        YMargin(70),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Investment Summary",
                            style: TextStyle(fontFamily: AppStrings.fontMedium),
                          ),
                        ),
                        YMargin(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: AppUtils.getBoxShaddow),
                            height: screenHeight(context) / 2.2,
                            width: screenWidth(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YMargin(27),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "INVESTMENT NAME (Zimvest High Yield Dollar)",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: AppStrings.fontMedium,
                                          color: AppColors.kLightText5,
                                        ),
                                      ),
                                      YMargin(8),
                                      Text(
                                        "${paymentViewModel.investmentName}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: AppStrings.fontBold,
                                          color: AppColors.kTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(40),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 23.0, right: 23.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "INTEREST RATE",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${paymentViewModel.pickeddollarInstrument.rate}% P.A",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kFixed,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "NEXT MATURITY DATE",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${paymentViewModel.pickeddollarInstrument.maturityDate}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(40),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 23.0, right: 23.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "AMOUNT",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.dollarSymbol}${paymentViewModel.investmentAmount.toString().split('.')[0].convertWithComma()}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "PROCESSING FEE (1.5%)",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.dollarSymbol}${0.015 * paymentViewModel.investmentAmount}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(40),
                                Padding(
                                  padding: const EdgeInsets.only(left: 23.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "TOTAL",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.dollarSymbol}${((0.015 * paymentViewModel.investmentAmount) + paymentViewModel.investmentAmount).toString().split('.')[0].convertWithComma()}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                //top: MediaQuery.of(context).size.height - 100,
                top: slideUp == true
                    ? -60
                    : (MediaQuery.of(context).size.height - 100),
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) async {
                    if (network.neTisOn) {
                      startAnim();
                      await model.buyDollarInstrument(
                          walletType: widget.walletType,
                          amount: paymentViewModel.investmentAmount,
                          productId: paymentViewModel.pickeddollarInstrument.id,
                          uniqueName: paymentViewModel.investmentName,
                          fundingChannel: widget.channelId);

                      paymentViewModel.amountController.clear();
                    } else {
                      cautionFlushBar(context, "No Network",
                          "Please make sure you are connected to the internet");
                    }
                  },
                  child: Container(
                    height: 60,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.kWhite,
                            ),
                            Text(
                              "Swipe up to confirm",
                              style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestmentSummaryScreenDollarWired extends StatefulWidget {
  final File pickedImage;

  const InvestmentSummaryScreenDollarWired({Key key, this.pickedImage})
      : super(key: key);
  static Route<dynamic> route({File pickedImage}) {
    return MaterialPageRoute(
      builder: (_) => InvestmentSummaryScreenDollarWired(
        pickedImage: pickedImage,
      ),
      settings: RouteSettings(
        name: InvestmentSummaryScreenDollarWired().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentSummaryScreenDollarWiredState createState() =>
      _InvestmentSummaryScreenDollarWiredState();
}

class _InvestmentSummaryScreenDollarWiredState
    extends State<InvestmentSummaryScreenDollarWired> {
  List<GlobalKey<ItemFaderState>> keys;

  bool loading = false;

  final _tween = MultiTween<AniProps>()
    ..add(
        AniProps.offset1,
        Tween(begin: Offset(0, 10), end: Offset(0, 0)),
        800.milliseconds,
        Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ))
    ..add(
        AniProps.scale,
        Tween(begin: 0.0, end: 1.0),
        800.milliseconds,
        Interval(
          0.0,
          0.6,
          curve: Curves.bounceInOut,
        ))
    ..add(
        AniProps.opacity1,
        0.0.tweenTo(1.0),
        800.milliseconds,
        Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ));

  bool confirmed = false;

  bool slideUp = false;

  @override
  void initState() {
    keys = List.generate(2, (index) => GlobalKey<ItemFaderState>());

    super.initState();
  }

  void startAnim() async {
    setState(() {
      slideUp = true;
      loading = true;
    });
  }

  void onInit() async {
    for (var key in keys) {
      key.currentState.show();
    }
  }

  ConnectionProvider network;
  ABSPaymentViewModel paymentViewModel;
  InvestmentHighYieldViewModel investmentModel;
  @override
  Widget build(BuildContext context) {
    network = Provider.of(context);
    paymentViewModel = Provider.of(context);
    investmentModel = Provider.of(context);
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.kSecondaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              slideUp ? SvgPicture.asset("images/patterns.svg", fit: BoxFit.fill,): Container(),
              Positioned.fill(
                child: model.busy
                    ? Center(
                        child: LoadingWIdget(),
                      )
                    : model.status
                        ? PlayAnimation<MultiTweenValues<AniProps>>(
                            tween: _tween,
                            duration: _tween.duration,
                            builder: (context, child, value) {
                              return Container(
                                // color: Colors.white,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(
                                      flex: 2,
                                    ),
                                    Transform.scale(
                                      scale: value.get(AniProps.scale),
                                      child: Transform.translate(
                                        offset: value.get(AniProps.offset1),
                                        child: Opacity(
                                          opacity: value.get(AniProps.opacity1),
                                          child: Text(
                                            "Awaiting Confirmation",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    AppStrings.fontMedium,
                                                color: AppColors.kWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Transform.scale(
                                      scale: value.get(AniProps.scale),
                                      child: Transform.translate(
                                        offset: value.get(AniProps.offset1),
                                        child: Opacity(
                                          opacity: value.get(AniProps.opacity1),
                                          child: SvgPicture.asset(
                                              "images/new/confetti.svg"),
                                        ),
                                      ),
                                    ),
                                    YMargin(40),
                                    Transform.scale(
                                      scale: value.get(AniProps.scale),
                                      child: Transform.translate(
                                        offset: value.get(AniProps.offset1),
                                        child: Opacity(
                                          opacity: slideUp
                                              ? value.get(AniProps.opacity1)
                                              : 0.0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              "Transaction will be confirmed between 48 - 72 hours",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Transform.scale(
                                      scale: value.get(AniProps.scale),
                                      child: Transform.translate(
                                        offset: value.get(AniProps.offset1),
                                        child: Opacity(
                                          opacity: slideUp
                                              ? value.get(AniProps.opacity1)
                                              : 0.0,
                                          child: PrimaryButtonNew(
                                            onTap: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TabsContainer()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            },
                                            textColor: Colors.white,
                                            title: "Done",
                                            bg: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    YMargin(50)
                                  ],
                                ),
                              );
                            },
                          )
                        : model.busy
                            ? Center(child: LoadingWIdget())
                            : model.status
                                ? Text(
                                    model.status.toString(),
                                    style: TextStyle(color: AppColors.kWhite),
                                  )
                                : PlayAnimation<MultiTweenValues<AniProps>>(
                                    tween: _tween,
                                    duration: _tween.duration,
                                    builder: (context, child, value) {
                                      return Container(
                                        width: screenWidth(context),
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Spacer(),
                                              Transform.scale(
                                                scale:
                                                    value.get(AniProps.scale),
                                                child: Transform.translate(
                                                  offset: value
                                                      .get(AniProps.offset1),
                                                  child: Opacity(
                                                    opacity: value
                                                        .get(AniProps.opacity1),
                                                    child: SvgPicture.asset(
                                                        "images/new/errfetti.svg"),
                                                  ),
                                                ),
                                              ),
                                              YMargin(40),
                                              Transform.scale(
                                                scale:
                                                    value.get(AniProps.scale),
                                                child: Transform.translate(
                                                  offset: value
                                                      .get(AniProps.offset1),
                                                  child: Opacity(
                                                    opacity: slideUp
                                                        ? value.get(
                                                            AniProps.opacity1)
                                                        : 0.0,
                                                    child: Text(
                                                      "Your investment was not successful",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Transform.scale(
                                                scale:
                                                    value.get(AniProps.scale),
                                                child: Transform.translate(
                                                  offset: value
                                                      .get(AniProps.offset1),
                                                  child: Opacity(
                                                    opacity: slideUp
                                                        ? value.get(
                                                            AniProps.opacity1)
                                                        : 0.0,
                                                    child: PrimaryButtonNew(
                                                      onTap: () {
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TabsContainer()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                      },
                                                      textColor: Colors.white,
                                                      title: "Retry",
                                                      bg: AppColors
                                                          .kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              YMargin(50)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: slideUp ? -(MediaQuery.of(context).size.height - 200) : 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      boxShadow: AppUtils.getBoxShaddow3),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackButton(
                              color: AppColors.kPrimaryColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: InkWell(
                                onTap: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabsContainer()),
                                    (Route<dynamic> route) => false),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontNormal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            // XMargin(1),
                          ],
                        ),
                        YMargin(70),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Investment Summary",
                            style: TextStyle(fontFamily: AppStrings.fontMedium),
                          ),
                        ),
                        YMargin(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: AppUtils.getBoxShaddow),
                            height: screenHeight(context) / 2.2,
                            width: screenWidth(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YMargin(27),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "INVESTMENT NAME (Zimvest High Yield Dollar)",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: AppStrings.fontMedium,
                                          color: AppColors.kLightText5,
                                        ),
                                      ),
                                      YMargin(8),
                                      Text(
                                        "${paymentViewModel.investmentName}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: AppStrings.fontBold,
                                          color: AppColors.kTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(40),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 23.0, right: 23.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "amount in dollars".toUpperCase(),
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.dollarSymbol}${paymentViewModel.investmentAmount.toString().split('.')[0].convertWithComma()}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "amount in naira".toUpperCase(),
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.nairaSymbol}${(paymentViewModel.investmentAmount * investmentModel.exchangeRate).toString().split('.')[0].convertWithComma()}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(40),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 23.0, right: 23.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "PROCESSING FEE (1.5%)",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.dollarSymbol}${(0.015 * paymentViewModel.investmentAmount).toString().split('.')[0].convertWithComma()}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "INTEREST RATE",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${paymentViewModel.pickeddollarInstrument.rate}%",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kFixed,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                YMargin(40),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 23.0, right: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "TOTAL",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${AppStrings.dollarSymbol}${((0.015 * paymentViewModel.investmentAmount) + paymentViewModel.investmentAmount).toString().split('.')[0].convertWithComma()}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "NEXT MATURITY DATE",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(8),
                                          Text(
                                            "${paymentViewModel.pickeddollarInstrument.maturityDate}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontBold,
                                              color: AppColors.kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                //top: MediaQuery.of(context).size.height - 100,
                top: slideUp == true
                    ? -60
                    : (MediaQuery.of(context).size.height - 100),
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) {
                    if (network.neTisOn) {
                      startAnim();
                      model.buyDollarInstrumentWired(
                        beneficiaryBankType: 1,
                        proofOfPayment: widget.pickedImage,
                        amount: paymentViewModel.investmentAmount,
                        productId: paymentViewModel.pickeddollarInstrument.id,
                        uniqueName: paymentViewModel.investmentName,
                        fundingChannel: 4,
                      );
                      paymentViewModel.amountController.clear();
                    } else {
                      cautionFlushBar(context, "No Network",
                          "Please make sure you are connected to the internet");
                    }
                  },
                  child: Container(
                    height: 60,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.kWhite,
                            ),
                            Text(
                              "Swipe up to confirm",
                              style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
