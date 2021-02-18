import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/wallet/dollar/choose_funding_source.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/flushbar.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';
import 'package:zimvest/widgets/number_keyboard.dart';

class FundDollarWallet extends StatefulWidget {
  final List<Wallet> wallet;
  final num rate;

  const FundDollarWallet({Key key, this.wallet, this.rate}) : super(key: key);
  static Route<dynamic> route({List<Wallet> wallet, num rate}) {
    return MaterialPageRoute(
      builder: (_) => FundDollarWallet(
        wallet: wallet,
        rate: rate,
      ),
      settings: RouteSettings(
        name: FundDollarWallet().toStringShort(),
      ),
    );
  }

  @override
  _FundDollarWalletState createState() => _FundDollarWalletState();
}

class _FundDollarWalletState extends State<FundDollarWallet> {
  // var amountController =
  // MoneyMaskedTextController(thousandSeparator: ",", decimalSeparator: ".");
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ZimAppBar(
        icon: Icons.arrow_back_ios,
        callback: () {
          Navigator.pop(context);
        },
        text: "",
        showCancel: true,
      ),
      body: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(height > 750 ?72: 35),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 76),
              child: Text(
                "Fund Dollar Wallet",
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: AppStrings.fontBold,
                  color: AppColors.kTextColor,
                ),
              ),
            ),
            YMargin(36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kTextBg,
                    borderRadius: BorderRadius.circular(12)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: paymentViewModel.amountController.text == ""
                      ? Text(
                          "Enter Amount",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: AppStrings.fontLight,
                            color: AppColors.kLightTitleText,
                          ),
                        )
                      : Text(
                          convertWithComma(
                              paymentViewModel.amountController.text),
                          style: TextStyle(fontSize: 15),
                        ),
                ),
              ),
            ),
            YMargin(10),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                paymentViewModel.amountController.text == ""
                    ? ""
                    : "₦ ${(double.tryParse(paymentViewModel.amountController.text.split(',').join()) * widget.rate).toString().split('.')[0].convertWithComma()} (1 USD = ${widget.rate.toString().split(".").first.convertWithComma()} NGN)",
                style: TextStyle(
                  fontSize: 12,

                  color: AppColors.kFixed,
                ),
              ),
            ),
            YMargin(height > 750 ?70:30),
            RoundedNextButton(
              onTap: () {
                double amount = double.tryParse(
                    paymentViewModel.amountController.text.split(',').join());
                double balance = widget.wallet
                    .where((element) => element.currency == "NGN")
                    .first
                    .balance;
                if (paymentViewModel.amountController.text == "0.00") {
                  errorFlushBar(
                      context, "Error !", "You have to fill in an amount");
                } else if (amount < 5) {
                  errorFlushBar(context, "Error !", "Insufficient Funds");
                } else {
                  paymentViewModel.investmentAmount = amount;
                  paymentViewModel.conversionRate = widget.rate;
                  Navigator.push(
                    context,
                    FundDollarWalletPaymentOption.route(
                      nairaRate: widget.rate,
                      amount: amount,
                      balance: balance,
                    ),
                  );
                }
              },
            ),
            YMargin(7),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wallet Ballance ",style: TextStyle(
                  fontSize: 14,
                  fontFamily: AppStrings.fontNormal,
                  color: AppColors.kTextColor,
                )),
                Text(AppStrings.nairaSymbol,style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                )),
                Text(
                  "${StringUtils(widget.wallet.where((element)
                  => element.currency == "NGN").first.balance.toString().split('.')[0]).convertWithComma()}",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: AppStrings.fontBold,
                    color: AppColors.kTextColor,
                  ),
                ),
              ],
            ),
            NumericKeyboard(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              onKeyboardTap: paymentViewModel.onKeyboardTap,
              rightIcon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kPrimaryColor,
              ),
              rightButtonFn: () {
                setState(
                  () {
                    paymentViewModel.amountController.text =
                        paymentViewModel.amountController.text.substring(0,
                            paymentViewModel.amountController.text.length - 1);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  convertWithComma(String newValue) {
    String value = newValue;
    var buffer = new StringBuffer();

    if (value.length == 4) {
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
    } else if (value.length == 5) {
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
    } else if (value.length == 6) {
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
    } else if (value.length == 7) {
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(',');
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(value[6]);
    } else if (value.length == 8) {
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(',');
      buffer.write(value[5]);
      buffer.write(value[6]);
      buffer.write(value[7]);
    } else if (value.length == 9) {
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(',');
      buffer.write(value[6]);
      buffer.write(value[7]);
      buffer.write(value[8]);
    } else {
      for (int i = 0; i < value.length; i++) {
        print('lllllf $i');
        buffer.write(value[i]);
        var nonZeroIndex = i + 1;

        if (nonZeroIndex % 3 == 0 && nonZeroIndex != value.length) {
          buffer.write(',');
        }
      }
    }

    return buffer.toString();
  }
}
