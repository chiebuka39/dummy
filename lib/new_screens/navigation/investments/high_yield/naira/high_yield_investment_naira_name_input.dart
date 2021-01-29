import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/util_widgt.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

import '../../../../tabs.dart';
import 'high_yield_investment_naira_amount_input.dart';

class HighYieldInvestmentNairaUniqueName extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentNairaUniqueName(),
      settings: RouteSettings(
        name: HighYieldInvestmentNairaUniqueName().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldInvestmentNairaUniqueNameState createState() =>
      _HighYieldInvestmentNairaUniqueNameState();
}

class _HighYieldInvestmentNairaUniqueNameState
    extends State<HighYieldInvestmentNairaUniqueName> {
  TextEditingController investmentName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      onModelReady: (model) => model.getNairaTermInstruments(),
      builder: (context, model, _) => Scaffold(
        // appBar: ,
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          text: "Invest",
          showCancel: true,
          callback: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              YMargin(72),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 76),
                child: Text(
                  "Name Your Zimvest High Yield Naira Investment",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: AppStrings.fontBold,
                    color: AppColors.kTextColor,
                  ),
                ),
              ),
              YMargin(36),
              InvestmentTextField(
                  readOnly: false,
                  controller: investmentName,
                  hintText: "Enter a unique name"),
              YMargin(252),
              RoundedNextButton(
                onTap: () {
                  paymentViewModel.investmentName = investmentName.text;
                  List<num> minimumAmount = model.nairaInstrument.data
                      .map((e) => e.minAmount)
                      .toList();
                  print(minimumAmount);
                  List<num> minimumAmounts = [];
                  for (var i in minimumAmount) {
                    if (i > 0) {
                      minimumAmounts.add(i);
                    }
                  }
                  if (investmentName.text == "") {
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
                        "Field Cannot be left empty",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: AppStrings.fontLight,
                          color: AppColors.kRed4,
                        ),
                      ),
                      duration: Duration(seconds: 3),
                    ).show(context);
                  } else {

                    Navigator.push(
                      context,
                      InvestmentHighYieldNairaAmountInput.route(
                        uniqueName: investmentName.text,
                        minimumAmount: minimumAmounts.reduce(min).toDouble(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
