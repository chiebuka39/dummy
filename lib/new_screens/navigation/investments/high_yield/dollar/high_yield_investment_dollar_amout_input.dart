import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_dollar_purchase_source.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/number_keyboard.dart';

class InvestmentHighYieldDollarAmountInput extends StatefulWidget {
  final String uniqueName;
  final int id;
  final String duration;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;

  const InvestmentHighYieldDollarAmountInput(
      {Key key,
      this.uniqueName,
      this.id,
      this.duration,
      this.maturityDate,
      this.rate,
      this.minimumAmount,
      this.maximumAmount})
      : super(key: key);
  static Route<dynamic> route({
    String uniqueName,
    int id,
    String duration,
    String maturityDate,
    String rate,
    String minimumAmount,
    String maximumAmount,
  }) {
    return MaterialPageRoute(
      builder: (_) => InvestmentHighYieldDollarAmountInput(
          uniqueName: uniqueName,
          id: id,
          maturityDate: maturityDate,
          rate: rate,
          minimumAmount: minimumAmount,
          maximumAmount: maximumAmount),
      settings: RouteSettings(
        name: InvestmentHighYieldDollarAmountInput().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentHighYieldDollarAmountInputState createState() =>
      _InvestmentHighYieldDollarAmountInputState();
}

class _InvestmentHighYieldDollarAmountInputState
    extends State<InvestmentHighYieldDollarAmountInput> {
  // static String amountController.text;
  TextEditingController amountController;
  @override
  void initState() {
    amountController = TextEditingController();
    super.initState();
  }

  // TODO: Fix the textController make it make sense
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
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(72),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 76),
                child: Text(
                  "How much do you want to invest",
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
                  "Minimum of ${widget.minimumAmount} and Maximum of Above ${widget.maximumAmount}",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kTextColor,
                  ),
                ),
              ),
              YMargin(14),
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
                  Navigator.push(
                    context,
                    HighYieldInvestmentDollarPurchaseSource.route(
                      uniqueName: widget.uniqueName,
                      id: widget.id,
                      maturityDate: widget.maturityDate,
                      rate: widget.rate,
                      minimumAmount: widget.minimumAmount,
                      maximumAmount: widget.maximumAmount,
                      amount: amountController.text,
                    ),
                  );
                  // }
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
                  setState(() {
                    amountController.text = amountController.text
                        .substring(0, amountController.text.length - 1);
                  });
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
