import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/new_screens/funding/wallet/naira/fund_with_dollar_wallet_summary.dart';
import 'package:zimvest/widgets/flushbar.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/number_keyboard.dart';
import 'package:zimvest/utils/app_utils.dart';

class FundNairaWalletWithDollar extends StatefulWidget {
  final List<Wallet> wallet;
  final num rate;

  const FundNairaWalletWithDollar({Key key, this.wallet, this.rate})
      : super(key: key);
  static Route<dynamic> route({List<Wallet> wallet, num rate}) {
    return MaterialPageRoute(
      builder: (_) => FundNairaWalletWithDollar(
        wallet: wallet,
        rate: rate,
      ),
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
  var amountController =
      MoneyMaskedTextController(thousandSeparator: ",", decimalSeparator: ".");
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
        builder: (context) => Column(
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
            InvestmentTextField(
                controller: amountController, hintText: "Enter amount"),
            YMargin(10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                amountController.text == ""
                    ? ""
                    : "₦ ${double.tryParse(amountController.text.split(',').join()) * widget.rate} (1 USD = 390.0 NGN)",
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
                double amount =
                    double.tryParse(amountController.text.split(',').join());
                double balance = widget.wallet
                    .where((element) => element.currency == "USD")
                    .first
                    .balance;
                if (amountController.text == "0.00") {
                  errorFlushBar(context, "Error !", "You have to fill in an amount");
                } else if (amount > balance) {
                  errorFlushBar(context, "Error !", "Insufficient Funds");
                } else {
                  Navigator.push(
                    context,
                    DollarFundingSummaryScreen.route(
                        nairaRate: widget.rate,
                        amount: amount,
                        balance: balance),
                  );
                }
              },
            ),
            YMargin(7),
            Center(
              child: Text(
                "Wallet Ballance ${AppStrings.dollarSymbol}${StringUtils(widget.wallet.where((element) => element.currency == "USD").first.balance.toString().split('.')[0]).convertWithComma()}",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppStrings.fontNormal,
                  color: AppColors.kTextColor,
                ),
              ),
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
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      amountController.text = amountController.text + value;
    });
  }
}
