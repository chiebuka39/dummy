import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/corporate_bonds/fixed_income_purchase.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/widgets/number_keyboard.dart';

class FixedIncomeAmountInput extends StatefulWidget {
  final String uniqueName;
  final int investmentId;
  final String bondName;
  final String maturityDate;
  final double rate;
  final int investmentType;
  final int instrumentId;
  final num minimumAmount;
  final String investmentMaturityDate;

  const FixedIncomeAmountInput({
    Key key,
    this.uniqueName,
    this.investmentId,
    this.bondName,
    this.maturityDate,
    this.rate,
    this.investmentType,
    this.instrumentId,
    this.minimumAmount,
    this.investmentMaturityDate,
  }) : super(key: key);
  static Route<dynamic> route({
    String uniqueName,
    int investmentId,
    String bondName,
    String maturityDate,
    double rate,
    int investmentType,
    int instrumentId,
    num minimumAmount,
    String investmentMaturityDate,
  }) {
    // print("minimumAmount $minimumAmount");
    return MaterialPageRoute(
      builder: (_) => FixedIncomeAmountInput(
        bondName: bondName,
        uniqueName: uniqueName,
        investmentId: investmentId,
        maturityDate: maturityDate,
        rate: rate,
        investmentType: investmentType,
        instrumentId: instrumentId,
        minimumAmount: minimumAmount,
        investmentMaturityDate: investmentMaturityDate,
      ),
      settings: RouteSettings(
        name: FixedIncomeAmountInput().toStringShort(),
      ),
    );
  }

  @override
  _FixedIncomeAmountInputState createState() => _FixedIncomeAmountInputState();
}

class _FixedIncomeAmountInputState extends State<FixedIncomeAmountInput> {
  // static String amountController.text;
  // var amountController =
  //     MoneyMaskedTextController(decimalSeparator: ".", thousandSeparator: ",");
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getCards(),
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
                padding: const EdgeInsets.only(left: 20.0, right: 76),
                child: Text(
                  "Minimum of ${AppStrings.nairaSymbol}${widget.minimumAmount.toString().split('.')[0].convertWithComma()}",
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
                  double amount =
                      double.tryParse(paymentViewModel.amountController.text.split(',').join());
                  if (amount < widget.minimumAmount) {
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
                        "Minimum purchase amount is ₦${StringUtils(widget.minimumAmount.toString()).convertWithComma()}",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontLight,
                          color: AppColors.kRed4,
                        ),
                      ),
                      duration: Duration(seconds: 1),
                    ).show(context);
                  } else {
                    Navigator.push(
                      context,
                      FixedIncomePurchaseSource.route(
                        cards: model.cards,
                        amount: amount,
                        productId: widget.investmentId,
                        uniqueName: widget.uniqueName,
                        maturityDate: widget.maturityDate,
                        rate: widget.rate,
                        investmentType: widget.investmentType,
                        instrumentId: widget.instrumentId,
                        minimumAmount: widget.minimumAmount,
                        investmentMaturityDate: widget.investmentMaturityDate,
                      ),
                    );
                  }
                },
              ),
              NumericKeyboard(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onKeyboardTap: paymentViewModel.onKeyboardTap,
                rightIcon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.kPrimaryColor,
                ),
                rightButtonFn: () {
                  setState(() {
                    paymentViewModel.amountController.text = paymentViewModel.amountController.text
                        .substring(0, paymentViewModel.amountController.text.length - 1);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // _onKeyboardTap(String value) {
  //   setState(() {
  //     amountController.text = amountController.text + value;
  //   });
  // }
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
