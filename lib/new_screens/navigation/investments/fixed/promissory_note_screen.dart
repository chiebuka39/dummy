import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/styles/colors.dart';

class PromissoryNotePage extends StatefulWidget {
  @override
  _PromissoryNotePageState createState() => _PromissoryNotePageState();
}

class _PromissoryNotePageState extends State<PromissoryNotePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      onModelReady: (model) => model.getPromissoryNote(),
      builder: (context, model, _) => Container(
        child: Center(
          child: model.promissoryNote.data == null
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kGreen),
                )
              : model.promissoryNote.data.length == 0 ? Text(
                  "Not Available"
                ): Text(
                  model.promissoryNote.data.length.toString(),
                ),
        ),
      ),
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
    );
  }
}