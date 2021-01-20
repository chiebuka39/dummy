import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_naira_purchase_source.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/investment_duration.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/widgets/number_keyboard.dart';

class InvestmentHighYieldNairaAmountInput extends StatefulWidget {
  final double minimumAmount;
  final String uniqueName;

  const InvestmentHighYieldNairaAmountInput({Key key, this.minimumAmount, this.uniqueName})
      : super(key: key);
  static Route<dynamic> route({
    double minimumAmount,
    String uniqueName
  }) {
    return MaterialPageRoute(
      builder: (_) => InvestmentHighYieldNairaAmountInput(
        minimumAmount: minimumAmount,
        uniqueName: uniqueName,
      ),
      settings: RouteSettings(
        name: InvestmentHighYieldNairaAmountInput().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentHighYieldNairaAmountInputState createState() =>
      _InvestmentHighYieldNairaAmountInputState();
}

class _InvestmentHighYieldNairaAmountInputState
    extends State<InvestmentHighYieldNairaAmountInput> {
  // static String amountController.text;
  var amountController =
      MoneyMaskedTextController(thousandSeparator: ",", decimalSeparator: ".");

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
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
                  showCursor: false,
                  controller: amountController,
                  hintText: "Enter amount"),
              YMargin(10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  "Minimum of ${AppStrings.nairaSymbol}${StringUtils(widget.minimumAmount.toString()).convertWithComma()}",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kTextColor,
                  ),
                ),
              ),
              YMargin(77),
              RoundedNextButton(
                loading: model.busy,
                onTap: () async {
                  double amount =
                      double.tryParse(amountController.text.split(',').join());
                  if (amount == null) {
                    Flushbar(
                      icon: ImageIcon(
                        AssetImage("images/failed.png"),
                        color: AppColors.kRed,
                        size: 70,
                      ),
                      margin: EdgeInsets.all(12),
                      borderRadius: 20,
                      flushbarPosition: FlushbarPosition.TOP,
                      titleText: Text(
                        "Error !",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kRed4,
                        ),
                      ),
                      backgroundColor: AppColors.kRed3,
                      messageText: Text(
                        "Field Cannot be Empty",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontLight,
                          color: AppColors.kRed4,
                        ),
                      ),
                      duration: Duration(seconds: 3),
                    ).show(context);
                  } else if (amount < widget.minimumAmount) {
                    Flushbar(
                      icon: ImageIcon(
                        AssetImage("images/failed.png"),
                        color: AppColors.kRed,
                        size: 70,
                      ),
                      margin: EdgeInsets.all(12),
                      borderRadius: 20,
                      flushbarPosition: FlushbarPosition.TOP,
                      titleText: Text(
                        "Error !",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: AppStrings.fontBold,
                          color: AppColors.kRed4,
                        ),
                      ),
                      backgroundColor: AppColors.kRed3,
                      messageText: Text(
                        "Minimum purchase amount is ${AppStrings.nairaSymbol}${StringUtils(widget.minimumAmount.toString()).convertWithComma()}",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontLight,
                          color: AppColors.kRed4,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } else {
                    await model.getNairaTermInstrumentsFilter(amount);
                    Navigator.push(
                      context,
                      InvestmentDurationPeriod.route(
                        amount: amount,
                        instrument: model.nairaInstrument.data,
                        uniqueName: widget.uniqueName,
                      ),
                    );
                  }
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
