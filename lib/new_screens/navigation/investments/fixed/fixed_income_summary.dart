import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:supercharged_dart/supercharged_dart.dart';
import 'package:supercharged/supercharged.dart';

import '../../../tabs.dart';

class FixedIncomeInvestmentSummary extends StatefulWidget {
  final double amount;
  final int productId;
  final int channelId;
  final String uniqueName;
  final String duration;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;

  const FixedIncomeInvestmentSummary(
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
    String minimumAmount,
    String maximumAmount,
  }) {
    return MaterialPageRoute(
      builder: (_) => FixedIncomeInvestmentSummary(
          amount: amount,
          productId: productId,
          channelId: channelId,
          uniqueName: uniqueName,
          maturityDate: maturityDate,
          rate: rate,
          minimumAmount: minimumAmount,
          maximumAmount: maximumAmount),
      settings: RouteSettings(
        name: FixedIncomeInvestmentSummary().toStringShort(),
      ),
    );
  }

  @override
  _FixedIncomeInvestmentSummaryState createState() =>
      _FixedIncomeInvestmentSummaryState();
}

class _FixedIncomeInvestmentSummaryState
    extends State<FixedIncomeInvestmentSummary> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
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
              if (details.delta.dy == -0.5) {
                model.buyNairaInstrument(
                    amount: widget.amount,
                    productId: widget.productId,
                    uniqueName: widget.uniqueName,
                    fundingChannel: widget.channelId);
              }
              // print("swiped ${details.delta.dy}");
              // Navigator.of(context).push(_createRoute());
            }
          },
          child: Stack(
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
                                          "${AppStrings.nairaSymbol}${widget.amount}",
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SavingsSummaryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SavingsSummaryScreen(),
        settings: RouteSettings(name: SavingsSummaryScreen().toStringShort()));
  }

  @override
  _SavingsSummaryScreenState createState() => _SavingsSummaryScreenState();
}

class _SavingsSummaryScreenState extends State<SavingsSummaryScreen> {
  List<GlobalKey<ItemFaderState>> keys;

  // ABSSavingViewModel savingViewModel;
  // ABSIdentityViewModel identityViewModel;
  // ABSPaymentViewModel paymentViewModel;
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
    // var result = await savingViewModel.topUp(
    //     cardId: paymentViewModel.selectedCard?.id ?? null,
    //     token: identityViewModel.user.token,
    //     custSavingId: savingViewModel.selectedPlan.id,
    //     fundingChannel: paymentViewModel.selectedCard == null
    //         ? savingViewModel.fundingChannels
    //             .firstWhere((element) => element.name == "Wallet")
    //             .id
    //         : savingViewModel.fundingChannels
    //             .firstWhere((element) => element.name == "Card")
    //             .id,
    //     savingsAmount: savingViewModel.amountToSave);
    // print("ooooo ${result.error}");
    // print("4444 ${result.errorMessage}");
    // if (result.error == false) {
    //   setState(() {
    //     loading = false;
    //     confirmed = true;
    //   });
    //   Future.delayed(1000.milliseconds).then((value) => onInit());
    // }
  }

  void onInit() async {
    for (var key in keys) {
      //await Future.delayed(Duration(seconds: 1));
      key.currentState.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    // identityViewModel = Provider.of(context);
    // savingViewModel = Provider.of(context);
    // paymentViewModel = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: confirmed
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
                                            opacity:
                                                value.get(AniProps.opacity1),
                                            child: SvgPicture.asset(
                                                "images/new/confetti.svg")))),
                                YMargin(40),
                                ItemFader(
                                    offset: 10,
                                    curve: Curves.easeIn,
                                    key: keys[0],
                                    child: Text(
                                      "Your Topup was succesful",
                                      style: TextStyle(color: Colors.white),
                                    )),
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
                  : SizedBox(),
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
                          "Savings Summary",
                          style: TextStyle(fontFamily: AppStrings.fontMedium),
                        ),
                      ),
                      YMargin(20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        height: 280,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            boxShadow: AppUtils.getBoxShaddow3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Plan name".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.kSecondaryText,
                                fontFamily: AppStrings.fontNormal,
                              ),
                            ),
                            YMargin(15),
                            Text(
                              "savingViewModel.selectedPlan.planName",
                              style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,
                                  color: AppColors.kGreyText),
                            ),
                            YMargin(40),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "amount".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.kSecondaryText,
                                        fontFamily: AppStrings.fontNormal,
                                      ),
                                    ),
                                    YMargin(15),
                                    Text(
                                      "${AppStrings.nairaSymbol}savingViewModel.amountToSave",
                                      style: TextStyle(
                                          fontFamily: AppStrings.fontMedium,
                                          fontSize: 13,
                                          color: AppColors.kGreyText),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Next maturity date".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.kSecondaryText,
                                        fontFamily: AppStrings.fontNormal,
                                      ),
                                    ),
                                    YMargin(15),
                                    Text(
                                      AppUtils.getReadableDate(DateTime.now()),
                                      style: TextStyle(
                                          fontFamily: AppStrings.fontMedium,
                                          fontSize: 13,
                                          color: AppColors.kGreyText),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            YMargin(40),
                            Text(
                              "Interest rate".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.kSecondaryText,
                                fontFamily: AppStrings.fontNormal,
                              ),
                            ),
                            YMargin(15),
                            Text(
                              "savingViewModel.selectedPlan.interestRate% P.A",
                              style: TextStyle(
                                  fontFamily: AppStrings.fontMedium,
                                  fontSize: 13,
                                  color: AppColors.kGreyText),
                            ),
                          ],
                        ),
                      )
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
                onPanUpdate: (details) {
                  if (details.delta.dy < 0) {
                    print(details.delta.dx);
                    startAnim();
                  }
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
            Container(
              height: size.height,
              width: size.width,
              child: Center(
                child: loading ? CircularProgressIndicator() : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
