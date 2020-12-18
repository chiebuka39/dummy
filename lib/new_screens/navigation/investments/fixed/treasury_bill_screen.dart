import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';

class TreasuryBillPage extends StatefulWidget {
  @override
  _TreasuryBillPageState createState() => _TreasuryBillPageState();
}

class _TreasuryBillPageState extends State<TreasuryBillPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getTreasuryBill(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.treasuryBills.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kGreen),
                )
              : model.treasuryBills.data.tBillsItems == null ? Text(
                  "Not Available"
                ): Text(
                  model.treasuryBills.data.tBillsItems[0].treasureBills.length.toString(),
                ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}
