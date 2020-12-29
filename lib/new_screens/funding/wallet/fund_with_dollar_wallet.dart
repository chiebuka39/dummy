import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/funding/wallet/fund_with_dollar_wallet_summary.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/number_keyboard.dart';

class FundNairaWalletWithDollar extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => FundNairaWalletWithDollar(),
      settings: RouteSettings(
        name: FundNairaWalletWithDollar().toStringShort(),
      ),
    );
  }

  @override
  _FundNairaWalletWithDollarState createState() =>
      _FundNairaWalletWithDollarState();
}

class _FundNairaWalletWithDollarState extends State<FundNairaWalletWithDollar> {
  // static String amountController.text;
  TextEditingController amountController;
  @override
  void initState() {
    amountController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(72),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 76),
                child: Text(
                  "Fund Naira Wallet With Dollar Wallet",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: AppStrings.fontBold,
                    color: AppColors.kTextColor,
                  ),
                ),
              ),
              YMargin(36),
              InvestmentTextFieldDollar(
                  // initalValue: "1",
                  controller: amountController,
                  hintText: "Enter amount"),
              YMargin(10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  amountController.text == ""
                      ? ""
                      : "₦ ${double.tryParse(amountController.text) * 390} (1 USD = 390.0 NGN)",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kFixed,
                  ),
                ),
              ),
              YMargin(70),
              RoundedNextButton(
                onTap: () {
                  double amount = double.tryParse(amountController.text);
                  // if (amount < ) {
                  //   Flushbar(
                  //     icon: ImageIcon(
                  //       AssetImage("images/failed.png"),
                  //       color: AppColors.kRed,
                  //       size: 70,
                  //     ),
                  //     margin: EdgeInsets.all(12),
                  //     borderRadius: 20,
                  //     flushbarPosition: FlushbarPosition.TOP,
                  //     titleText: Text(
                  //       "Error !",
                  //       style: TextStyle(
                  //         fontSize: 13,
                  //         fontFamily: AppStrings.fontBold,
                  //         color: AppColors.kRed4,
                  //       ),
                  //     ),
                  //     backgroundColor: AppColors.kRed3,
                  //     messageText: Text(
                  //       "Minimum purchase amount is ${widget.minimumAmount}",
                  //       style: TextStyle(
                  //         fontSize: 11,
                  //         fontFamily: AppStrings.fontLight,
                  //         color: AppColors.kRed4,
                  //       ),
                  //     ),
                  //     duration: Duration(seconds: 1),
                  //   ).show(context);
                  // } else {
                  // }
                  Navigator.push(context, DollarFundingSummaryScreen.route());
                },
              ),
              NumericKeyboard(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onKeyboardTap: _onKeyboardTap,
                rightIcon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.kPrimaryColor,
                ),
                rightButtonFn: () {
                  setState(
                    () {
                      amountController.text = amountController.text
                          .substring(0, amountController.text.length - 1);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      amountController.text = amountController.text + value;
    });
  }
}
