import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

import 'high_yield_investment_naira_amount_input.dart';

class HighYieldInvestmentNairaUniqueName extends StatefulWidget {
  final int id;
  final String duration;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;

  const HighYieldInvestmentNairaUniqueName(
      {Key key,
      this.id,
      this.duration,
      this.maturityDate,
      this.rate,
      this.minimumAmount,
      this.maximumAmount})
      : super(key: key);

  static Route<dynamic> route({
    int id,
    String duration,
    String maturityDate,
    String rate,
    String minimumAmount,
    String maximumAmount,
  }) {
    print("minimumAmount $minimumAmount");
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentNairaUniqueName(
          id: id,
          duration: duration,
          maturityDate: maturityDate,
          rate: rate,
          minimumAmount: minimumAmount,
          maximumAmount: maximumAmount),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(72),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 76),
              child: Text(
                "Name Your Zimvest High Yield Naira ${widget.duration} Investment",
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
                InvestmentHighYieldNairaAmountInput.route(
                    uniqueName: investmentName.text,
                    id: widget.id,
                    duration: widget.duration,
                    maturityDate: widget.maturityDate,
                    rate: widget.rate,
                    minimumAmount: widget.minimumAmount,
                    maximumAmount: widget.maximumAmount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
