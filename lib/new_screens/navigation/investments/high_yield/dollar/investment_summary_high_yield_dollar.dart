import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/terms_and_conditions_box.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/widgets/buttons.dart';
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
      this.maximumAmount})
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
          maximumAmount: maximumAmount),
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
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.kSecondaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: model.status
                    ? PlayAnimation<MultiTweenValues<AniProps>>(
                        tween: _tween,
                        duration: _tween.duration,
                        builder: (context, child, value) {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
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
                                  ItemFader(
                                    offset: 10,
                                    curve: Curves.easeIn,
                                    key: keys[0],
                                    child: Text(
                                      "You Have Successfully Invested In Zimvest High Yield Naira",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Spacer(),
                                  ItemFader(
                                    offset: 10,
                                    curve: Curves.easeIn,
                                    key: keys[1],
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
                                  YMargin(50)
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : model.busy
                        ? Center(child: CircularProgressIndicator())
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
                                                    model.buyDollarInstrument(
                                                        amount: widget.amount,
                                                        productId:
                                                            widget.productId,
                                                        uniqueName:
                                                            widget.uniqueName,
                                                        fundingChannel:
                                                            widget.channelId);
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
                        BackButton(
                          color: AppColors.kPrimaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                YMargin(27),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "INVESTMENT NAME (Zimvest High Yield Naira ${widget.duration} Days)",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppStrings.fontMedium,
                                        color: AppColors.kLightText5,
                                      ),
                                    ),
                                    Text(
                                      "${widget.uniqueName}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppStrings.fontBold,
                                        color: AppColors.kTextColor,
                                      ),
                                    ),
                                  ],
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
                                          Text(
                                            "${widget.rate} P.A",
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
                                            "NEXT MATURITY DATE",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          Text(
                                            "${widget.maturityDate}",
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
                                          Text(
                                            "${AppStrings.nairaSymbol}${StringUtils(widget.minimumAmount.toString()).convertWithComma()}",
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
                                          Text(
                                            "${AppStrings.nairaSymbol}${0.015 * widget.amount}",
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
                                          Text(
                                            "${AppStrings.nairaSymbol}${(0.015 * widget.amount) + widget.amount}",
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
                    startAnim();
                    model.buyDollarInstrument(
                        amount: widget.amount,
                        productId: widget.productId,
                        uniqueName: widget.uniqueName,
                        fundingChannel: widget.channelId);
                  },
                  // onVerticalDragStart: (details) {
                  //   print("dff ${details.toString()}");
                  //   //
                  // },
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
              // Container(
              //   height: size.height,
              //   width: size.width,
              //   child: Center(
              //     child: model.busy ? CircularProgressIndicator() : SizedBox(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget summarySreen(context) {
  return Stack(
    children: [
      Positioned(
        top: 0,
        right: 0,
        left: 0,
        child: Container(
          height: screenHeight(context) / 1.4,
          width: screenWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: AppColors.kWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(73),
                Text(
                  "Investment Summary",
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: AppStrings.fontMedium,
                    color: AppColors.kTextColor,
                  ),
                ),
                YMargin(27),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: AppUtils.getBoxShaddow),
                  height: screenHeight(context) / 2.2,
                  width: screenWidth(context),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YMargin(27),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "INVESTMENT NAME (Zimvest High Yield Naira 30 Days)",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontMedium,
                              color: AppColors.kLightText5,
                            ),
                          ),
                          Text(
                            "Good vibes",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: AppStrings.fontBold,
                              color: AppColors.kTextColor,
                            ),
                          ),
                        ],
                      ),
                      YMargin(40),
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  "6% P.A",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  "Feb 29, 2020",
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
                        padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  "${AppStrings.nairaSymbol}20,000,000",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: AppStrings.fontBold,
                                    color: AppColors.kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  "${AppStrings.nairaSymbol}30,000",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(
                                  "${AppStrings.nairaSymbol}20,030,000",
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
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 34,
        left: 50,
        right: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kWhite,
              ),
            ),
            Text(
              "Swipe up to confirm",
              style: TextStyle(
                fontSize: 13,
                fontFamily: AppStrings.fontLight,
                color: AppColors.kWhite,
              ),
            ),
          ],
        ),
      )
    ],
  );
}

class InvestmentSummaryScreenDollarWired extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => InvestmentSummaryScreenDollarWired(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTextColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy < 0) {
            Navigator.push(context, InvestmentConfirmationDollarWired.route());
          }
        },
        child: summarySreen(context),
      ),
    );
  }
}
