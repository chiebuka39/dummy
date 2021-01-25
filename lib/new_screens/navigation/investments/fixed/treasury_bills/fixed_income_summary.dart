import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/widgets/new/anim.dart';

import '../../../../tabs.dart';

class SavingsSummaryScreen extends StatefulWidget {
  final String uniqueName;
  final int investmentId;
  final String bondName;
  final String maturityDate;
  final double rate;
  final int investmentType;
  final int instrumentId;
  final num minimumAmount;
  final String investmentMaturityDate;
  final double amount;
  final int channelId;
  final int intermediaryBankType;
  const SavingsSummaryScreen(
      {Key key,
      this.uniqueName,
      this.maturityDate,
      this.rate,
      this.investmentType,
      this.instrumentId,
      this.minimumAmount,
      this.investmentMaturityDate,
      this.investmentId,
      this.bondName,
      this.amount,
      this.channelId,
      this.intermediaryBankType})
      : super(key: key);
  static Route<dynamic> route({
    double amount,
    int investmentId,
    String uniqueName,
    String bondName,
    String maturityDate,
    double rate,
    int minimumAmount,
    int investmentType,
    int instrumentId,
    String investmentMaturityDate,
    int channelId,
    int intermediaryBankType,
  }) {
    print("Duration $bondName");
    return MaterialPageRoute(
      builder: (_) => SavingsSummaryScreen(
        bondName: bondName,
        investmentId: investmentId,
        maturityDate: maturityDate,
        rate: rate,
        investmentType: investmentType,
        instrumentId: instrumentId,
        minimumAmount: minimumAmount,
        investmentMaturityDate: investmentMaturityDate,
        amount: amount,
        uniqueName: uniqueName,
        channelId: channelId,
        intermediaryBankType: intermediaryBankType,
      ),
      settings: RouteSettings(
        name: SavingsSummaryScreen().toStringShort(),
      ),
    );
  }

  @override
  _SavingsSummaryScreenState createState() => _SavingsSummaryScreenState();
}

class _SavingsSummaryScreenState extends State<SavingsSummaryScreen> {
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
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return ViewModelProvider<FixedIncomeViewModel>.withConsumer(
      viewModelBuilder: () => FixedIncomeViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.kSecondaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
             fit: StackFit.expand,
            children: [
              SvgPicture.asset("images/patterns.svg", fit: BoxFit.fill,),
              Positioned.fill(
                child: model.busy
                    ? Center(child: CircularProgressIndicator())
                    : model.status
                        ? PlayAnimation<MultiTweenValues<AniProps>>(
                            tween: _tween,
                            duration: _tween.duration,
                            builder: (context, child, value) {
                              return Container(
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
                                          offset: value.get(AniProps.offset1),
                                          child: Opacity(
                                            opacity:
                                                value.get(AniProps.opacity1),
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
                                            child: Text(
                                              "You Have Successfully Invested In ${widget.bondName}",
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
                                                      "${model.message}",
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
                                                      title: "Done",
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
                //top: -(MediaQuery.of(context).size.height - 200),
                top: slideUp ? -(MediaQuery.of(context).size.height - 200) : 0,
                left: 0, right: 0,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YMargin(27),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "INVESTMENT NAME (${widget.bondName})",
                                        // textAlign: TextAlign.start,
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
                                            "${AppStrings.nairaSymbol}${widget.amount.toString().split('.')[0].convertWithComma()}",
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
                top: slideUp == true
                    ? -60
                    : (MediaQuery.of(context).size.height - 100),
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) {
                    startAnim();
                    model.buyTreasuryBills(
                      cardId: paymentViewModel.selectedCard == null
                          ? null
                          : paymentViewModel.selectedCard.id,
                      productId: widget.investmentId,
                      instrumentId: widget.instrumentId,
                      fundingChannel: widget.channelId,
                      investmentAmount: widget.amount,
                      maturityDate: DateTime.tryParse(widget.maturityDate),
                      rate: widget.rate,
                      instrumentName: widget.bondName,
                      uniqueName: widget.uniqueName,
                      instrumentType: 3,
                    );
                    paymentViewModel.amountController.clear();
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
