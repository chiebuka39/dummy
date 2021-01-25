import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged_dart/supercharged_dart.dart';
import 'package:supercharged/supercharged.dart';
import 'package:zimvest/animations/loading.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/upload_proof_of_payment.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/delete_wealthbox.dart';
import 'package:zimvest/widgets/new/anim.dart';

import '../../../tabs.dart';
import '../../top_up_successful.dart';

class FundDollarWalletSummaryScreen extends StatefulWidget {
  final double amount;
  final double balance;
  final double nairaRate;
  final bool isWallet;

  const FundDollarWalletSummaryScreen(
      {Key key, this.amount, this.balance, this.nairaRate, this.isWallet})
      : super(key: key);
  static Route<dynamic> route(
      {double amount, double balance, double nairaRate, bool isWallet}) {
    return MaterialPageRoute(
      builder: (_) => FundDollarWalletSummaryScreen(
        amount: amount,
        balance: balance,
        nairaRate: nairaRate,
        isWallet: isWallet,
      ),
      settings: RouteSettings(
        name: FundDollarWalletSummaryScreen().toStringShort(),
      ),
    );
  }

  @override
  _FundDollarWalletSummaryScreenState createState() =>
      _FundDollarWalletSummaryScreenState();
}

class _FundDollarWalletSummaryScreenState
    extends State<FundDollarWalletSummaryScreen> {
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
    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      builder: (context, model, _) => Scaffold(
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
                child: model.busy
                    ? Center(child: LoadingWIdget())
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
                                              "Successfully Processed Payment",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                YMargin(36),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      YMargin(5),
                                      Text(
                                        "${AppStrings.nairaSymbol}${widget.balance.toString().split('.')[0].convertWithComma()}",
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
                                            "AMOUNT IN NAIRA",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(5),
                                          Text(
                                            "${AppStrings.nairaSymbol} ${widget.amount.toString().split('.')[0].convertWithComma()}",
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
                                            "AMOUNT IN DOLLAR",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: AppStrings.fontMedium,
                                              color: AppColors.kLightText5,
                                            ),
                                          ),
                                          YMargin(5),
                                          Text(
                                            "${AppStrings.dollarSymbol} ${(widget.amount / widget.nairaRate).toString().split('.')[0].convertWithComma()}",
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
                top: slideUp == true
                    ? -60
                    : (MediaQuery.of(context).size.height - 100),
                left: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) {
                    startAnim();
                    // num nairaAmount = widget.amount * widget.nairaRate;
                    model.fundWallet(
                        sourceAmount: widget.amount, currency: "USD");
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



class WiredTransferScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => WiredTransferScreen(),
      settings: RouteSettings(
        name: WiredTransferScreen().toStringShort(),
      ),
    );
  }

  @override
  _WiredTransferScreenState createState() => _WiredTransferScreenState();
}

class _WiredTransferScreenState extends State<WiredTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
        actions: [
          FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppStrings.fontMedium,
                  color: AppColors.kPrimaryColor),
            ),
            onPressed: () {
              showModalBottomSheet<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return CancelAction();
                  },
                  isScrollControlled: true);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(69),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Wired Transfer",
              style: TextStyle(
                fontSize: 15,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          YMargin(22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding:
                  EdgeInsets.only(left: 27, right: 26, top: 29, bottom: 28),
              height: screenHeight(context) / 1.7,
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.kWhite,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Color(0x20000000),
                    spreadRadius: -0.1,
                    offset: Offset(1.5, 1.5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wired Transfer Details",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: AppStrings.fontBold,
                      color: AppColors.kTextColor,
                    ),
                  ),
                  YMargin(10),
                  Text(
                    "Kindly note that this mode of payment may 2 - 5 working days depending on your bank",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: AppStrings.fontNormal,
                      color: AppColors.kTextColor,
                    ),
                  ),
                  YMargin(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary name:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2,
                        child: Text(
                          "ZEDCREST INVESTMENT MANAGERS LIMITED",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary address:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "177A Ligali Ayorinde, Victoria Island,Lagos",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary bank:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "First City Monument Bank  Limited",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Beneficiary account number:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 3.15,
                        child: Text(
                          "6643633035",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Account number:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "0101254445850",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Swit code:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "FCMBNGLA",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  YMargin(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bank address:",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kTextColor,
                        ),
                      ),
                      Container(
                        width: screenWidth(context) / 2.15,
                        child: Text(
                          "17a Tinubu Street, Lagos Island, Lagos, Nigeria",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppStrings.fontNormal,
                            color: AppColors.kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          YMargin(58),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 87),
            child: PrimaryButtonNew(
              title: "I have made payment",
              onTap: () => Navigator.push(
                context,
                UploadProofOfPayment.route(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
