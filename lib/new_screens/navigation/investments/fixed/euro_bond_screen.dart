import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';

class EuroBondPage extends StatefulWidget {
  @override
  _EuroBondPageState createState() => _EuroBondPageState();
}

class _EuroBondPageState extends State<EuroBondPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getEuroBond(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.euroBond.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kGreen),
                )
              : model.euroBond.data.euroBondItems[0].bonds.length == 0 ? Text(
                  "Not Available"
                ): Text(
                  model.euroBond.data.euroBondItems[0].bonds.length.toString(),
                ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}