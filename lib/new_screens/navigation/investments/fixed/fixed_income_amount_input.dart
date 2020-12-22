import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_purchase.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_naira_purchase_source.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/nums.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class FixedIncomeAmountInput extends StatefulWidget {
  final String uniqueName;
  final int investmentId;
  final String bondName;
  final String maturityDate;
  final String rate;


  const FixedIncomeAmountInput(
      {Key key,
      this.uniqueName,
      this.investmentId,
      this.bondName,
      this.maturityDate,
      this.rate,})
      : super(key: key);
  static Route<dynamic> route({
    String uniqueName,
    int investmentId,
    String bondName,
    String maturityDate,
    String rate,
  }) {
    // print("minimumAmount $minimumAmount");
    return MaterialPageRoute(
      builder: (_) => FixedIncomeAmountInput(
        bondName: bondName,
          uniqueName: uniqueName,
          investmentId: investmentId,
          maturityDate: maturityDate,
          rate: rate,),
      settings: RouteSettings(
        name: FixedIncomeAmountInput().toStringShort(),
      ),
    );
  }

  @override
  _FixedIncomeAmountInputState createState() =>
      _FixedIncomeAmountInputState();
}

class _FixedIncomeAmountInputState
    extends State<FixedIncomeAmountInput> {
  // static String amountController.text;
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kWhite,
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
          builder: (context) => Column(
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
              InvestmentTextField(
                  controller: amountController, hintText: "Enter amount"),
              YMargin(10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 76),
                child: Text(
                  "How much do you want to invest",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppStrings.fontBold,
                    color: AppColors.kTextColor,
                  ),
                ),
              ),
              YMargin(91),
              RoundedNextButton(
                onTap: () {
                  Navigator.push(context, FixedIncomePurchaseSource.route());
                  // // double.tryParse(widget.minimumAmount)
                  // double amount = double.tryParse(amountController.text);
                  // if (amount < AppNums.oneMillionAmount) {
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
                  //       "Minimum purchase amount is ₦5,000,001.00",
                  //       style: TextStyle(
                  //         fontSize: 11,
                  //         fontFamily: AppStrings.fontLight,
                  //         color: AppColors.kRed4,
                  //       ),
                  //     ),
                  //     duration: Duration(seconds: 1),
                  //   ).show(context);
                  // } else {
                  //   Navigator.push(
                  //     context,
                      // HighYieldInvestmentPurchaseSource.route(
                        
                  //         amount: amount,
                  //         productId: widget.id,
                  //         uniqueName: widget.uniqueName,
                  //         maturityDate: widget.maturityDate,
                  //         rate: widget.rate,
                  //         minimumAmount: widget.minimumAmount,
                  //         maximumAmount: widget.maximumAmount),
                  //   );
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
