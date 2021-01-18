import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_naira_purchase_source.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/navigation/checkBox.dart';

class InvestmentDurationPeriod extends StatefulWidget {
  final List<TermInstrument> instrument;
  final double amount;
  final String uniqueName;

  const InvestmentDurationPeriod(
      {Key key, this.instrument, this.amount, this.uniqueName})
      : super(key: key);
  static Route<dynamic> route(
      {double amount, List<TermInstrument> instrument, String uniqueName}) {
    return MaterialPageRoute(
      builder: (_) => InvestmentDurationPeriod(
        amount: amount,
        instrument: instrument,
        uniqueName: uniqueName,
      ),
      settings: RouteSettings(
        name: InvestmentDurationPeriod().toStringShort(),
      ),
    );
  }

  @override
  _InvestmentDurationPeriodState createState() =>
      _InvestmentDurationPeriodState();
}

class _InvestmentDurationPeriodState extends State<InvestmentDurationPeriod> {
  @override
  Widget build(BuildContext context) {
    List<TermInstrument> instrument = widget.instrument
        .where((element) => element.minAmount == widget.amount)
        .toList();
    // print(instrument.length);

    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getCards(),
      builder: (context, model, _) => Scaffold(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(69),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "How long do you want to invest for ?",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: AppStrings.fontBold,
                  color: AppColors.kTextColor,
                ),
              ),
            ),
            YMargin(15),
            instrument.length == 0 ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 250),
              child: Text("There are no available investments for ${widget.amount}", textAlign: TextAlign.center,),
            ): Expanded(
              child: ListView.builder(
                itemCount: instrument.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      model.check();
                      Navigator.push(
                        context,
                        HighYieldInvestmentPurchaseSource.route(
                          amount: widget.amount,
                          cards: model.cards,
                          productId: instrument[index].id,
                          rate: instrument[index].rate,
                          maturityDate: instrument[index].maturityDate,
                          uniqueName: widget.uniqueName,
                          duration: instrument[index].maturityPeriod,
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                instrument[index].instrumentName,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kTextColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "(${instrument[index].rate.toString()}%)",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: AppStrings.fontNormal,
                                  color: AppColors.kFixed,
                                ),
                              ),
                              XMargin(8),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 600),
                                child: model.select ? check : checkEmpty,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}