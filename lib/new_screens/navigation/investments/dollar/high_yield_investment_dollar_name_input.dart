import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/dollar/high_yield_investment_dollar_amout_input.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldInvestmentDollarUniqueName extends StatefulWidget {
  final String instrumentName;

  const HighYieldInvestmentDollarUniqueName({Key key, this.instrumentName}) : super(key: key);
  static Route<dynamic> route(String name) {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentDollarUniqueName(instrumentName: name,),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(72),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 76),
              child: Text(
                "Name Your Zimvest High Yield Dollar ${widget.instrumentName} Days Investment",
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
                context,
                InvestmentHighYieldDollarAmountInput.route(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
