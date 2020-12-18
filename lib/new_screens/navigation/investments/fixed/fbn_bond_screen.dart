import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';

class FBNBondPagePage extends StatefulWidget {
  @override
  _FBNBondPagePageState createState() => _FBNBondPagePageState();
}

class _FBNBondPagePageState extends State<FBNBondPagePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getFGNBond(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.fgnBond.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kGreen),
                )
              : model.fgnBond.data.length == 0
                  ? Text("Not Available")
                  : Text(
                      model.fgnBond.data.length.toString(),
                    ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}
