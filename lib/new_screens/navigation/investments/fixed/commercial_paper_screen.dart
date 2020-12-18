import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';

class CommercialPaperPage extends StatefulWidget {
  @override
  _CommercialPaperPageState createState() => _CommercialPaperPageState();
}

class _CommercialPaperPageState extends State<CommercialPaperPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getCommercialPaper(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.commercialPaper.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kGreen),
                )
              : model.commercialPaper.data.length == 0 ? Text(
                  "Not Available"
                ): Text(
                  model.commercialPaper.data.length.toString(),
                ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}
