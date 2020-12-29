import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/corporate_bonds/fixed_income_amount_input.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/text_field.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class FixedIncomeUniqueName extends StatefulWidget {
  final int investmentId;
  final String bondName;
  final String maturityDate;
  final double rate;
  final int investmentType;
  final int instrumentId;
  final num minimumAmount;
  final String investmentMaturityDate;

  const FixedIncomeUniqueName({
    Key key,
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
    int investmentId,
    String bondName,
    String maturityDate,
    double rate,
    int investmentType,
    int instrumentId,
    num minimumAmount,
    String investmentMaturityDate,
  }) {
    return MaterialPageRoute(
      builder: (_) => FixedIncomeUniqueName(
        investmentId: investmentId,
        bondName: bondName,
        maturityDate: maturityDate,
        rate: rate,
        investmentType: investmentType,
        instrumentId: instrumentId,
        minimumAmount: minimumAmount,
        investmentMaturityDate: investmentMaturityDate,
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
            Spacer(),
            // YMargin(72),
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
            // YMargin(36),
            Spacer(),
            InvestmentTextField(
                readOnly: false,
                controller: investmentName,
                hintText: "Enter a unique name"),
            // YMargin(252),
            Spacer(),
            RoundedNextButton(
              onTap: () => Navigator.push(
                context,
                FixedIncomeAmountInput.route(
                                   uniqueName: investmentName.text,
                  investmentId: widget.investmentId,
                  bondName: widget.bondName,
                  maturityDate: widget.maturityDate,
                  rate: widget.rate,
                  investmentType: widget.investmentType,
                  instrumentId: widget.instrumentId,
                  minimumAmount: widget.minimumAmount,
                  investmentMaturityDate: widget.investmentMaturityDate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
