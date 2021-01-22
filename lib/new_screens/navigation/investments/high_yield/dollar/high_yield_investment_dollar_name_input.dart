import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_dollar_amout_input.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/util_widgt.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldInvestmentDollarUniqueName extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentDollarUniqueName(),
      settings: RouteSettings(
        name: HighYieldInvestmentDollarUniqueName().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldInvestmentDollarUniqueNameState createState() =>
      _HighYieldInvestmentDollarUniqueNameState();
}

class _HighYieldInvestmentDollarUniqueNameState
    extends State<HighYieldInvestmentDollarUniqueName> {
  TextEditingController investmentName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      onModelReady: (model) => model.getDollarTermInstruments(),
      builder: (context, model, _) => Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              YMargin(72),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 76),
                child: Text(
                  "Name Your Zimvest High Yield Dollar Investment",
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
                  // print(model.dollarInstrument.data);
                  List<num> minimumAmount = model.dollarInstrument.data
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
                      InvestmentHighYieldDollarAmountInput.route(
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
