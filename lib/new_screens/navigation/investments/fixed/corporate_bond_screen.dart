import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';

class CorporateBondPage extends StatefulWidget {
  @override
  _CorporateBondPageState createState() => _CorporateBondPageState();
}

class _CorporateBondPageState extends State<CorporateBondPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getCorporateBond(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.corporateBond.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kGreen),
                )
              : model.corporateBond.data.length == 0 ? Text(
                  "Not Available"
                ): Text(
                  model.corporateBond.data.length.toString(),
                ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}
