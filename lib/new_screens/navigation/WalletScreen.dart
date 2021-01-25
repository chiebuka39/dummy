import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/funding/wallet/dollar/fund_dollar_wallet.dart';
import 'package:zimvest/new_screens/funding/wallet/exchange/exchange_to_dollars.dart';
import 'package:zimvest/new_screens/funding/wallet/naira/fund_with_dollar_wallet.dart';
import 'package:zimvest/new_screens/funding/wallet/wallet_withdraw_to.dart';
import 'package:zimvest/new_screens/navigation/widgets/money_title_widget.dart';
import 'package:zimvest/new_screens/navigation/widgets/transaction_item_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with AfterLayoutMixin<WalletScreen> {
  PageController controller = PageController();
  ABSIdentityViewModel identityViewModel;
  //WalletViewModel walletViewModel;

  bool showTopUp = true;

  int page = 0;

  @override
  void afterFirstLayout(BuildContext context) {
    //walletViewModel.getWalletTransactions();
  }

  @override
  void initState() {
    controller.addListener(() {
      print("vvvv ${controller.page}");
      if(controller.page == 0){
        setState(() {
          page = 0;
        });
      }else if(controller.page == 1){
        setState(() {
          page = 1;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    //walletViewModel = Provider.of(context);
    double tabWidth = MediaQuery.of(context).size.width - 40;
    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getWallets(),
      builder: (context, model, _) {
        List<Wallet> wallet = model.wallets;
        return Scaffold(
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColors.kSecondaryColor,
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Wallet",
                            style: TextStyle(color: AppColors.kWhite),
                          ),
                        ],
                      ),
                      YMargin(20),
                      Container(
                          height: 200,
                          width: double.infinity,
                          child: _walletCards(
                              context, identityViewModel.user.fullname)),
                      YMargin(15),
                      SmoothPageIndicator(
                          // controller: model.controller,
                          controller: controller, // PageController
                          count: 2,
                          effect: WormEffect(
                              dotWidth: 8,
                              dotHeight: 8,
                              activeDotColor: AppColors.kPrimaryColor,
                              dotColor: AppColors.kPrimaryColor
                                  .withOpacity(0.35)), // your preferred effect
                          onDotClicked: (index) {})
                    ],
                  ),
                ),
              ),
              page == 1 ?WalletTransactionCredit(tabWidth: tabWidth,currency: "USD",) :WalletTransactionCredit(tabWidth: tabWidth,),
            ],
          ),
        );
      },
    );
  }



  Widget _walletCards(
      BuildContext context,
      String name,
      ) {
    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getWallets(),
      builder: (context, model, _) {
        // int index = model.wallets.map((e) => e).toList().length;
        List<Wallet> wallet = model.wallets;
        return model.busy
            ? Center(child: Container())
            : PageView(
          controller: controller,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "Naira Wallet",
                    style: TextStyle(color: AppColors.kWhite),
                  ),
                  YMargin(15),
                  Row(
                    children: [
                      Spacer(),
                      MoneyTitleWidget(
                        // symbol: symbol,
                        amount: model.wallets
                            .where((element) => element.currency == "NGN")
                            .first
                            .balance,
                        textColor: AppColors.kWhite,
                      ),
                      Spacer(),
                    ],
                  ),
                  YMargin(10),
                  Text(
                    "Balance",
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 11,
                        fontFamily: AppStrings.fontNormal),
                  ),
                  YMargin(30),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () =>
                                bottomSheet(context, model.wallets, name),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.knewBlue,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/new/top_up.svg",
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                  YMargin(12),
                                  Text(
                                    "Fund Wallet",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.kWhite,
                                        fontFamily: AppStrings.fontNormal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(WalletWithdrawToScreen.route());
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.knewBlue,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/new/withdraw1.svg",
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                  YMargin(12),
                                  Text(
                                    "Withdraw",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.kWhite,
                                        fontFamily: AppStrings.fontNormal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Dollar Wallet",
                    style: TextStyle(color: AppColors.kWhite),
                  ),
                  YMargin(15),
                  Row(
                    children: [
                      Spacer(),
                      MoneyTitleWidgetDollar(
                        amount: model.wallets
                            .where((element) => element.currency == "USD")
                            .first
                            .balance,
                        textColor: AppColors.kWhite,
                      ),
                      Spacer(),
                    ],
                  ),
                  YMargin(10),
                  Text(
                    "Balance",
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 11,
                        fontFamily: AppStrings.fontNormal),
                  ),
                  YMargin(30),
                  ViewModelProvider<
                      InvestmentHighYieldViewModel>.withConsumer(
                    viewModelBuilder: () => InvestmentHighYieldViewModel(),
                    onModelReady: (model) => model.getRate(),
                    builder: (context, model, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              print("Some ${model.gotRate.data}");
                              Navigator.of(context).push(
                                FundDollarWallet.route(
                                  wallet: wallet,
                                  rate: model.gotRate.data.rate,
                                ),
                              );
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.knewBlue,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/new/top_up.svg",
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                  YMargin(12),
                                  Text(
                                    "Fund Wallet",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.kWhite,
                                        fontFamily: AppStrings.fontNormal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        XMargin(110),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  ExchangeToDollarsScreen.route(false));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: AppColors.knewBlue,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/new/withdraw1.svg",
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                  YMargin(12),
                                  Text(
                                    "Withdraw",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.kWhite,
                                        fontFamily: AppStrings.fontNormal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}



void bottomSheet(BuildContext context, List<Wallet> wallets, String name) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: screenHeight(context),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          YMargin(5),
          Container(
            height: screenHeight(context) / 1.822,
            width: screenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 33),
                  child: Text(
                    "Fund Wallet",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kTextColor,
                        fontSize: 15,
                        fontFamily: AppStrings.fontNormal),
                  ),
                ),
                YMargin(14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 133,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      boxShadow: AppUtils.getBoxShaddow,
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YMargin(25),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Account Information",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.kTextColor,
                                fontSize: 12,
                                fontFamily: AppStrings.fontNormal),
                          ),
                        ),
                        YMargin(17),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "$name",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.kTextColor,
                                fontSize: 14,
                                fontFamily: AppStrings.fontNormal),
                          ),
                        ),
                        YMargin(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            XMargin(2),
                            Text(
                              "${wallets.where((element) => element.currency == "NGN").first.walletNum}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kTextColor,
                                  fontSize: 13,
                                  fontFamily: AppStrings.fontNormal),
                            ),
                            XMargin(11),
                            Text(
                              "Providus Bank",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kTextColor,
                                  fontSize: 13,
                                  fontFamily: AppStrings.fontNormal),
                            ),
                            XMargin(44),
                            InkWell(
                              onTap: () => Clipboard.setData(ClipboardData(
                                      text:
                                          "${wallets.where((element) => element.currency == "NGN").first.walletNum}"))
                                  .then(
                                (_) {
                                  final toast = FToast(context);
                                  toast.showToast(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      height: 40,
                                      width: 120,
                                      child: Center(
                                        child: Text(
                                          'Copied!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.kTextColor,
                                              fontSize: 14,
                                              fontFamily:
                                                  AppStrings.fontNormal),
                                        ),
                                      ),
                                    ),
                                    toastDuration:
                                        Duration(milliseconds: 2500),
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                },
                              ),
                              child: Text(
                                "COPY",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 10,
                                    fontFamily: AppStrings.fontNormal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                YMargin(13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Please add 20 Naira to the amount you are transferring, this charge is applicable from the service provider",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.kTextColor,
                        fontSize: 11,
                        fontFamily: AppStrings.fontNormal),
                  ),
                ),
                YMargin(35),
                Center(
                  child: Text(
                    "Or",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.kTextColor,
                        fontSize: 12,
                        fontFamily: AppStrings.fontNormal),
                  ),
                ),
                YMargin(24),
                ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
                  viewModelBuilder: () => InvestmentHighYieldViewModel(),
                  onModelReady: (model) => model.getRate(),
                  builder: (context, model, _) => PaymentSourceButtonSpecial(
                    onTap: () {
                      Navigator.of(context).push(
                        FundNairaWalletWithDollar.route(
                            wallet: wallets, rate: model.gotRate.data.rate),
                      );
                    },
                    paymentsource: "Fund With Dollar Wallet",
                    color: AppColors.kPrimaryColorLight,
                    textColor: AppColors.kPrimaryColor,
                    iconColor: AppColors.kPrimaryColor,
                  ),
                ),
                YMargin(30),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}






class WalletTransactionCredit extends StatefulWidget {
  final double tabWidth;
  final String currency;

  const WalletTransactionCredit({Key key, this.tabWidth, this.currency = "NGN"}) : super(key: key);
  @override
  _WalletTransactionCreditState createState() => _WalletTransactionCreditState();
}

class _WalletTransactionCreditState extends State<WalletTransactionCredit>
    with AfterLayoutMixin<WalletTransactionCredit> {
  bool showTopUp = true;

  WalletViewModel walletViewModel;

  @override
  void afterFirstLayout(BuildContext context) {
    walletViewModel.getWalletTransactions();
  }

  @override
  Widget build(BuildContext context) {
    walletViewModel = Provider.of(context);
    return Container(

      child: DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.55,
        maxChildSize: 0.8,
        builder: (BuildContext context, myscrollController) {
          print("oooo ${myscrollController}");
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              controller: myscrollController,
              children: [
                YMargin(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 40,
                      color: AppColors.kGrey,
                      margin: EdgeInsets.symmetric(horizontal: 140),
                    ),
                  ],
                ),
                YMargin(20),
                Row(
                  children: <Widget>[
                    Spacer(),
                    Container(
                      width: widget.tabWidth,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.kPrimaryColorLight,
                          borderRadius:
                          BorderRadius.circular(13)),
                      child: Stack(
                        children: <Widget>[
                          AnimatedPositioned(
                            left: showTopUp == false
                                ? widget.tabWidth / 2
                                : 0,
                            duration:
                            Duration(milliseconds: 300),
                            child: Container(
                              width: widget.tabWidth / 2,
                              height: 40,
                              decoration: BoxDecoration(
                                  color:
                                  AppColors.kPrimaryColor,
                                  borderRadius:
                                  BorderRadius.circular(
                                      13)),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showTopUp = true;
                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "Top Ups",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: showTopUp ==
                                                  true
                                                  ? Colors
                                                  .white
                                                  : AppColors
                                                  .kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showTopUp = false;

                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "Withdrawals",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: showTopUp ==
                                                  false
                                                  ? Colors
                                                  .white
                                                  : AppColors
                                                  .kPrimaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                  ],
                ),
                if(showTopUp)
                  if(walletViewModel.walletTransaction == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        "No Transactions Yet",
                        textAlign: TextAlign.center,
                      ),
                    ) else ...List.generate(getTransaction( "Credit", widget.currency).length, (index) => TransactionItemWidget(
                    trans: ProductTransaction(status: 3),
                    symbol: getTransaction( "Credit", widget.currency)[index].currency == "NGN"
                        ? AppStrings.nairaSymbol
                        : AppStrings.dollarSymbol,
                    amount: getTransaction( "Credit", widget.currency)[index].amount,
                    date: getTransaction( "Credit", widget.currency)[index].date,
                    narration: getTransaction( "Credit", widget.currency)[index].narration,
                  ))
                else
                  if(walletViewModel.walletTransaction == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        "No Transactions Yet",
                        textAlign: TextAlign.center,
                      ),
                    ) else ...List.generate(getTransaction( "Debit", widget.currency).length, (index) => TransactionItemWidget(
                    trans: ProductTransaction(status: 3),
                    symbol: getTransaction( "Debit", widget.currency)[index].currency == "NGN"
                        ? AppStrings.nairaSymbol
                        : AppStrings.dollarSymbol,
                    amount: getTransaction( "Debit", widget.currency)[index].amount,
                    date: getTransaction( "Debit", widget.currency)[index].date,
                    narration: getTransaction( "Debit", widget.currency)[index].narration,
                  ))
              ],
            ),
          );
        },
      ),
    );
  }
  List<WalletTransaction> getTransaction( String type,String currency){
    return walletViewModel.walletTransaction
        .where((element) => element.movementType == type && element.currency == currency)
        .toList();
  }
}


