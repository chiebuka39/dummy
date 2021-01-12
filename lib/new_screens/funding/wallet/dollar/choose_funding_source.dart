import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/funding/wallet/dollar/fund_dollar_wallet_summary.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/flushbar.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class FundDollarWalletPaymentOption extends StatefulWidget {
  final double amount;
  final double balance;
  final double nairaRate;

  const FundDollarWalletPaymentOption(
      {Key key, this.amount, this.balance, this.nairaRate})
      : super(key: key);

  static Route<dynamic> route(
      {double amount, double balance, double nairaRate}) {
    return MaterialPageRoute(
      builder: (_) => FundDollarWalletPaymentOption(
        amount: amount,
        balance: balance,
        nairaRate: nairaRate,
      ),
      settings: RouteSettings(
        name: FundDollarWalletPaymentOption().toStringShort(),
      ),
    );
  }

  @override
  _FundDollarWalletPaymentOptionState createState() =>
      _FundDollarWalletPaymentOptionState();
}

class _FundDollarWalletPaymentOptionState
    extends State<FundDollarWalletPaymentOption>
    with SingleTickerProviderStateMixin {
  bool isNaira = true;
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Invest",
          style: TextStyle(
            fontSize: 13,
            fontFamily: AppStrings.fontMedium,
            color: AppColors.kTextColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(69),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 76),
            child: Text(
              "Choose Funding Option",
              style: TextStyle(
                fontSize: 17,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          verticalSpace(52),
          TabBar(
            controller: controller,
            tabs: [
              Tab(text: "Naira"),
              Tab(text: "Dollar"),
            ],
            unselectedLabelColor: AppColors.kLightText5,
            indicatorColor: AppColors.kPrimaryColor,
            labelColor: AppColors.kPrimaryColor,
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                Container(
                  child: Column(
                    children: [
                      YMargin(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SelectWallet(onPressed: () {
                          FundDollarWalletSummaryScreen.route(
                            amount: widget.amount,
                            balance: widget.balance,
                            nairaRate: widget.nairaRate,
                          );
                        }),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      YMargin(25),
                      YMargin(25),
                      PaymentSourceButtonSpecial(
                          paymentsource: "Wired Transfer",
                          image: "wallet",
                          onTap: () => cautionFlushBar(context, "Coming Soon!",
                              "This is not currently available")),
                      YMargin(25),
                      PaymentSourceButtonSpecial(
                        paymentsource: "R|rexelpay",
                        color: AppColors.kHighYield,
                        onTap: () => cautionFlushBar(context, "Coming Soon!",
                            "This is not currently available"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
