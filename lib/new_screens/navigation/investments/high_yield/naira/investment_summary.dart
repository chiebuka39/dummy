import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/funding/top_up_successful.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/investment_confirmation_naira.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:supercharged/supercharged.dart';

class InvestmentSummaryScreenNaira extends StatefulWidget {
  final double amount;
  final int productId;
  final int channelId;
  final String uniqueName;
  final String duration;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;

  const InvestmentSummaryScreenNaira(
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
      builder: (_) => InvestmentSummaryScreenNaira(
          amount: amount,
          productId: productId,
          channelId: channelId,
          uniqueName: uniqueName,
          maturityDate: maturityDate,
          rate: rate,
          minimumAmount: minimumAmount,
          maximumAmount: maximumAmount),
      settings: RouteSettings(
        name: InvestmentSummaryScreenNaira().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentSummaryScreenNairaState createState() =>
      _InvestmentSummaryScreenNairaState();
}

class _InvestmentSummaryScreenNairaState
    extends State<InvestmentSummaryScreenNaira> {
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        InvestmentConfirmationNaira(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}



