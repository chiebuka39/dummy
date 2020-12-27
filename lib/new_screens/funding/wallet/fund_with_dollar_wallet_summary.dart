import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged_dart/supercharged_dart.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

import '../../tabs.dart';
import '../top_up_successful.dart';

class DollarFundingSummaryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => DollarFundingSummaryScreen(),
      settings: RouteSettings(
        name: DollarFundingSummaryScreen().toStringShort(),
      ),
    );
  }

  @override
  _DollarFundingSummaryScreenState createState() => _DollarFundingSummaryScreenState();
}

class _DollarFundingSummaryScreenState extends State<DollarFundingSummaryScreen> {
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
                                    "Your Funding Is Being Processed",
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
                          "Dollar Wallet Funding",
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
                          height: screenHeight(context) / 4,
                          width: screenWidth(context),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YMargin(36),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "WALLET BALANCE",
                                      // textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppStrings.fontMedium,
                                        color: AppColors.kLightText5,
                                      ),
                                    ),
                                    Text(
                                      "\$20,500,000.00",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppStrings.fontBold,
                                        color: AppColors.kTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              YMargin(60),
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
                                          "AMOUNT IN DOLLARS",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: AppStrings.fontMedium,
                                            color: AppColors.kLightText5,
                                          ),
                                        ),
                                        Text(
                                          "\$25,000,000",
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
                                          "AMOUNT IN NAIRA",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: AppStrings.fontMedium,
                                            color: AppColors.kLightText5,
                                          ),
                                        ),
                                        Text(
                                          "\₦20,030,USD = ₦440)",
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
                              // YMargin(58)
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
                onPanUpdate: (details) {
                  if (details.delta.dy < 0) {
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
