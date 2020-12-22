import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_amount_input.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_naira_amount_input.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class FixedIncomeUniqueName extends StatefulWidget {
  final int investmentId;
  final String bondName;
  final String maturityDate;
  final String rate;

  const FixedIncomeUniqueName({
    Key key,
    this.investmentId,
    this.bondName,
    this.maturityDate,
    this.rate,
  }) : super(key: key);

  static Route<dynamic> route({
    int investmentId,
    String bondName,
    String maturityDate,
    String rate,
  }) {
    return MaterialPageRoute(
      builder: (_) => FixedIncomeUniqueName(
        investmentId: investmentId,
        bondName: bondName,
        maturityDate: maturityDate,
        rate: rate,
      ),
      settings: RouteSettings(
        name: FixedIncomeUniqueName().toStringShort(),
      ),
    );
  }

  @override
  _FixedIncomeUniqueNameState createState() => _FixedIncomeUniqueNameState();
}

class _FixedIncomeUniqueNameState extends State<FixedIncomeUniqueName> {
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
                "Name Your ${widget.bondName} Investment",
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
              onTap: () => Navigator.push(
                context,
                FixedIncomeAmountInput.route(
                  uniqueName: investmentName.text,
                  investmentId: widget.investmentId,
                  bondName: widget.bondName,
                  maturityDate: widget.maturityDate,
                  rate: widget.rate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
