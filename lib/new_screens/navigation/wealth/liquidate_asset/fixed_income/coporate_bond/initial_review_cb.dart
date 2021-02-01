import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/services/connectivity_service.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/liquidate_asset_vm.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/savings_summary.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/savings_summary.dart';
import 'package:zimvest/new_screens/navigation/wealth/investment_details.dart';
import 'package:zimvest/new_screens/withdrawals/use_pin_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/widgets/flushbar.dart';

import '../../../../../tabs.dart';

class InitialReviewScreenCorporateBond extends StatefulWidget {
  final String name;
  final double withDrawable;
  final int transactionId;
  final int instrumentId;
  final bool isBank;
  final List<Bank> banks;
  final int fixedInvestmentType;

  const InitialReviewScreenCorporateBond(
      {Key key,
      this.name,
      this.withDrawable,
      this.transactionId,
      this.instrumentId,
      this.isBank,
      this.banks,
      this.fixedInvestmentType})
      : super(key: key);
  static Route<dynamic> route(
      {String name,
      double withDrawable,
      int transactionId,
      int instrumentId,
      bool isBank,
      List<Bank> banks,
      int fixedInvestmentType}) {
    return MaterialPageRoute(
      builder: (_) => InitialReviewScreenCorporateBond(
        name: name,
        withDrawable: withDrawable,
        transactionId: transactionId,
        instrumentId: instrumentId,
        isBank: isBank,
        banks: banks,
        fixedInvestmentType: fixedInvestmentType,
      ),
      settings: RouteSettings(
        name: InitialReviewScreenCorporateBond().toStringShort(),
      ),
    );
  }

  @override
  _InitialReviewScreenState createState() => _InitialReviewScreenState();
}

class _InitialReviewScreenState
    extends State<InitialReviewScreenCorporateBond> {
  List<GlobalKey<ItemFaderState>> keys;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;
  LiquidateAssetViewModel liquidateAssetViewModel;
  ABSPinViewModel pinViewModel;
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
  bool error = false;
  String errorMessage = "Error Occured";

  @override
  void initState() {
    keys = List.generate(2, (index) => GlobalKey<ItemFaderState>());

    super.initState();
  }

  void startAnim(BuildContext context) async {
    setState(() {
      slideUp = true;
      loading = true;
    });
  }

  void startAnimWallet(BuildContext context) async {
    setState(() {
      slideUp = true;
      loading = true;
    });
    await Future.delayed(1000.milliseconds);
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) {
          return UsePinWidget(
            onNext: () {
              startAnim2(context);
            },
          );
        },
        isDismissible: false);
  }

  void startAnim2(BuildContext buildContext) async {
    var result = await liquidateAssetViewModel.liquidateNairaInstrument(
      transactionId: widget.transactionId,
      instrumentId: widget.instrumentId,
      bankId: paymentViewModel.selectedBank?.id,
      withdrawalOption: 2,
      amount: paymentViewModel.amountAvailable.toDouble(),
      pin:
          "${pinViewModel.pin1}${pinViewModel.pin2}${pinViewModel.pin3}${pinViewModel.pin4}",
      withdrawableAmount: paymentViewModel.withdrawableAmount.toInt(),
    );
    pinViewModel.resetPins();
    print("ooooo ${result.error}");
    print("4444 ${result.errorMessage}");
    if (result.error == false) {
      setState(() {
        loading = false;
        confirmed = true;
      });
      Future.delayed(1000.milliseconds).then((value) => onInit());
    } else {
      setState(() {
        loading = false;
        error = true;
        if (result.errorMessage != null) {
          errorMessage = result.errorMessage;
        }
      });
    }
  }

  void onInit() async {
    for (var key in keys) {
      key.currentState.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);

    pinViewModel = Provider.of(context);
    liquidateAssetViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    ConnectionProvider network = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return ViewModelProvider<FixedIncomeViewModel>.withConsumer(
      viewModelBuilder: () => FixedIncomeViewModel(),
      builder: (context, model, _) => widget.isBank
          ? Scaffold(
              backgroundColor: AppColors.kSecondaryColor,
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                     slideUp ? SvgPicture.asset("images/patterns.svg", fit: BoxFit.fill,): Container(),
                    Positioned(
                      top: slideUp
                          ? -(MediaQuery.of(context).size.height - 200)
                          : 0,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined),
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
                                              builder: (context) =>
                                                  TabsContainer()),
                                          (Route<dynamic> route) => false),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: AppColors.kPrimaryColor,
                                          fontSize: 12,
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
                                  "Review",
                                  style: TextStyle(
                                      fontFamily: AppStrings.fontMedium),
                                ),
                              ),
                              YMargin(20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhite,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: AppUtils.getBoxShaddow),
                                  height: screenHeight(context) / 4,
                                  width: screenWidth(context),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      YMargin(27),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PLAN NAME",
                                              // textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily:
                                                    AppStrings.fontMedium,
                                                color: AppColors.kLightText5,
                                              ),
                                            ),
                                            YMargin(5),
                                            Text(
                                              "${widget.name}",
                                              style: TextStyle(
                                                fontSize: 13,
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
                                        child: Column(
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
                                                fontFamily:
                                                    AppStrings.fontMedium,
                                                color: AppColors.kLightText5,
                                              ),
                                            ),
                                            YMargin(5),
                                            Text(
                                              "${AppStrings.nairaSymbol}${StringUtils(widget.withDrawable.toString().split('.')[0]).convertWithComma()}",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: AppStrings.fontBold,
                                                color: AppColors.kTextColor,
                                              ),
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
                          paymentViewModel.investmentName = widget.name;
                          // paymentViewModel.withdrawableAmount =
                          //     widget.withDrawable;
                          paymentViewModel.transactionId = widget.transactionId;
                          paymentViewModel.instrumentId = widget.instrumentId;
                          startAnim(context);
                          Navigator.push(
                            context,
                            SelectBankAccount.route(
                                investmentType: 6,
                                banks: widget.banks,
                                isLiquidate: true),
                          );
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
            )
          : WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                backgroundColor: AppColors.kSecondaryColor,
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SvgPicture.asset(
                        "images/patterns.svg",
                        fit: BoxFit.fill,
                      ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Transform.scale(
                                              scale: value.get(AniProps.scale),
                                              child: Transform.translate(
                                                  offset: value
                                                      .get(AniProps.offset1),
                                                  child: Opacity(
                                                      opacity: value.get(
                                                          AniProps.opacity1),
                                                      child: SvgPicture.asset(
                                                          "images/new/confetti.svg")))),
                                          YMargin(40),
                                          ItemFader(
                                              offset: 10,
                                              curve: Curves.easeIn,
                                              key: keys[0],
                                              child: Text(
                                                "Your Topup was succesful",
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                                    (Route<dynamic> route) =>
                                                        false);
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
                        top: slideUp
                            ? -(MediaQuery.of(context).size.height - 200)
                            : 0,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back_ios_outlined),
                                      color: AppColors.kPrimaryColor,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: InkWell(
                                        onTap: () =>
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TabsContainer()),
                                                (Route<dynamic> route) =>
                                                    false),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 12,
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
                                    "Review",
                                    style: TextStyle(
                                        fontFamily: AppStrings.fontMedium),
                                  ),
                                ),
                                YMargin(20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.kWhite,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: AppUtils.getBoxShaddow),
                                    height: screenHeight(context) / 4,
                                    width: screenWidth(context),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        YMargin(27),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "PLAN NAME",
                                                // textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily:
                                                      AppStrings.fontMedium,
                                                  color: AppColors.kLightText5,
                                                ),
                                              ),
                                              YMargin(5),
                                              Text(
                                                "${widget.name}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      AppStrings.fontBold,
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
                                          child: Column(
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
                                                  fontFamily:
                                                      AppStrings.fontMedium,
                                                  color: AppColors.kLightText5,
                                                ),
                                              ),
                                              YMargin(5),
                                              Text(
                                                "${AppStrings.nairaSymbol}${StringUtils(widget.withDrawable.toString().split('.')[0]).convertWithComma()}",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily:
                                                      AppStrings.fontBold,
                                                  color: AppColors.kTextColor,
                                                ),
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
                              startAnimWallet(context);
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
                      error == false
                          ? Container(
                              height: size.height,
                              width: size.width,
                              child: Center(
                                child: loading
                                    ? Center(
                                        child: LoadingWIdget(),
                                      )
                                    : SizedBox(),
                              ),
                            )
                          : Container(
                              height: size.height,
                              width: size.width,
                              child: Center(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    SvgPicture.asset("images/new/error2.svg"),
                                    YMargin(40),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        errorMessage,
                                        style: TextStyle(
                                            color: AppColors.kWhite,
                                            fontFamily: AppStrings.fontNormal,
                                            height: 1.7),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Spacer(),
                                    PrimaryButtonNew(
                                      title: "Back to Home",
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabsContainer()),
                                            (Route<dynamic> route) => false);
                                      },
                                    ),
                                    YMargin(40)
                                  ],
                                ),
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
