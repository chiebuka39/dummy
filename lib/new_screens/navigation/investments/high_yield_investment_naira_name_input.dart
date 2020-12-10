import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

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
    return Scaffold(
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
      body: Column(
        children: [
          YMargin(72),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 76),
            child: Text(
              "Name Your Zimvest High Yield Naira 30 Days Investment",
              style: TextStyle(
                fontSize: 17,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          YMargin(36),
          InvestmentTextField(
              controller: investmentName, hintText: "Enter a unique name"),
          YMargin(252),
          RoundedNextButton(
            onTap: () => Navigator.push(
                context, InvestmentHighYieldNairaAmountInput.route()),
          ),
        ],
      ),
    );
  }
}
