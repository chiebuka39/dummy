import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/services/connectivity_service.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/investment_duration.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/util_widgt.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/flushbar.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';
import 'package:zimvest/widgets/number_keyboard.dart';
import 'package:zimvest/utils/app_utils.dart';

import '../../../../tabs.dart';

class InvestmentHighYieldDollarAmountInput extends StatefulWidget {
  final String uniqueName;
  final int id;
  final String duration;
  final String maturityDate;
  final String rate;
  final double minimumAmount;
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
    double minimumAmount,
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
  @override
  Widget build(BuildContext context) {
    ConnectionProvider network = Provider.of(context);
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    InvestmentHighYieldViewModel investmentModel = Provider.of(context);
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          text: "Invest",
          showCancel: true,
          callback: () {
            Navigator.pop(context);
          },
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
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  "Minimum of ${AppStrings.dollarSymbol}${widget.minimumAmount.toString().split('.')[0].convertWithComma()}",
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
                  paymentViewModel.amountController.text == ""
                      ? ""
                      : "₦ ${(double.tryParse(paymentViewModel.amountController.text.split(',').join()) * investmentModel.exchangeRate.toDouble()).toString().split('.')[0].convertWithComma()} (1 USD = ${investmentModel.exchangeRate.toDouble()} NGN)",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kFixed,
                  ),
                ),
              ),
              YMargin(70),
              RoundedNextButton(
                loading: model.busy,
                onTap: () async {
                  if (network.neTisOn) {
                    double amount = double.tryParse(paymentViewModel
                        .amountController.text
                        .split(',')
                        .join());
                    paymentViewModel.investmentAmount = amount;
                    if (amount == null) {
                      errorFlushBar(context, "Error!", "Field Cannot be Empty");
                    } else if (amount < widget.minimumAmount) {
                      errorFlushBar(context, "Error!",
                          "Minimum purchase amount is \$${widget.minimumAmount.toString().split('.')[0].convertWithComma()}");
                    } else {
                      await model.getDollarTermInstrumentsFilter(amount);
                      Navigator.push(
                        context,
                        InvestmentDurationPeriod.route(
                          amount: amount,
                          instrument: model.dollarInstrument.data,
                          uniqueName: widget.uniqueName,
                        ),
                      );
                    }
                  } else {
                    cautionFlushBar(context, "No Network",
                        "Please make sure you are connected to the internet");
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
                    paymentViewModel.amountController.text =
                        paymentViewModel.amountController.text.substring(0,
                            paymentViewModel.amountController.text.length - 1);
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
  //     paymentViewModel.amountController.text = paymentViewModel.amountController.text + value;
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
