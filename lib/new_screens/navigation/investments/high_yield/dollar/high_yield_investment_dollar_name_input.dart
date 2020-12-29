import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_dollar_amout_input.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldInvestmentDollarUniqueName extends StatefulWidget {
  final String instrumentName;
  final int productId;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;

  const HighYieldInvestmentDollarUniqueName(
      {Key key,
      this.instrumentName,
      this.productId,
      this.maturityDate,
      this.rate,
      this.minimumAmount,
      this.maximumAmount})
      : super(key: key);
  static Route<dynamic> route({
    String duration,
    int productId,
    String maturityDate,
    String rate,
    String minimumAmount,
    String maximumAmount,
  }) {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentDollarUniqueName(
        instrumentName: duration,
        productId: productId,
        maturityDate: maturityDate,
        rate: rate,
        minimumAmount: minimumAmount,
        maximumAmount: maximumAmount,
      ),
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
          onPressed: () => Navigator.pop(context),
        ),
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
              readOnly: false,
                controller: investmentName, hintText: "Enter a unique name"),
            YMargin(252),
            RoundedNextButton(
              onTap: investmentName.text == "" ? null : () => Navigator.push(
                context,
                InvestmentHighYieldDollarAmountInput.route(
                  uniqueName: investmentName.text,
                  id: widget.productId,
                  duration: widget.instrumentName,
                  rate: widget.rate,
                  minimumAmount: widget.minimumAmount,
                  maximumAmount: widget.maximumAmount,
                  maturityDate: widget.maturityDate
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
