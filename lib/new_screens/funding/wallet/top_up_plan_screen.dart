import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/new_screens/funding/choose_funding_source.dart';
import 'package:zimvest/new_screens/funding/savings_summary.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/flushbar.dart';
import 'package:zimvest/widgets/number_keyboard.dart';

class TopUpPlanScreen extends StatefulWidget {
  final List<Wallet> wallets;
  final List<SavingPlanModel> savingsPlan;
  const TopUpPlanScreen({
    Key key,
    this.wallets, this.savingsPlan,
  }) : super(key: key);
  static Route<dynamic> route({List<Wallet> wallets, List<SavingPlanModel> savingsPlan}) {
    return MaterialPageRoute(
      builder: (_) => TopUpPlanScreen(
        savingsPlan: savingsPlan,
        wallets: wallets,
      ),
      settings: RouteSettings(
        name: TopUpPlanScreen().toStringShort(),
      ),
    );
  }

  @override
  _TopUpPlanScreenState createState() => _TopUpPlanScreenState();
}

class _TopUpPlanScreenState extends State<TopUpPlanScreen> {
  var amountController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  Widget build(BuildContext context) {
    double balance = widget.wallets
        .where((element) => element.currency == "NGN")
        .first
        .balance;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Top Up",
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "How much do you want to send to Zimvest Wealthbox",
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.kGreyText,
                  height: 1.7,
                  fontFamily: AppStrings.fontBold),
            ),
          ),
          YMargin(12),
          InvestmentTextField(
              controller: amountController, hintText: "Enter amount"),
          YMargin(77),
          RoundedNextButton(
            onTap: () {
              double amount =
                  double.tryParse(amountController.text.split(',').join());
              if (amountController.text == "0.00") {
                errorFlushBar(context, "Error!", "Input an amount");
              } 
              // else if (amount > balance) {
              //   errorFlushBar(context, "Insufficient Funds!",
              //       "You don't have enough money in your wallet");
              // } 
              else {
                Navigator.of(context).push(SavingsSummaryScreen.route(amount: amount,  savingsPlan: widget.savingsPlan));
              }
            },
          ),
          YMargin(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Wallet balance"),
              XMargin(5),
              Text(
                "${AppStrings.nairaSymbol}$balance",
                style: TextStyle(fontFamily: AppStrings.fontMedium),
              ),
            ],
          ),
          YMargin(50),
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
    );
  }

  _onKeyboardTap(String value) {
    setState(
      () {
        amountController.text = amountController.text + value;
      },
    );
  }
}
