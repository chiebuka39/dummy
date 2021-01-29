import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_naira_purchase_source.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/util_widgt.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/checkBox.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

import '../../../../tabs.dart';

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
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    List<TermInstrument> instrument = widget.instrument
        .where((element) => element.minAmount == widget.amount)
        .toList();
    // print(instrument.length);
    int selectedIndex;
    return ViewModelProvider<WalletViewModel>.withConsumer(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getCards(),
      builder: (context, model, _) => Scaffold(
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          text: "Invest",
          showCancel: true,
          callback: () {
            Navigator.pop(context);
          },
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
            YMargin(10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 250,
                child: Text(
                  "Choose from the list a tenure that is best suited for your financial goals",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppStrings.fontNormal,
                    color: AppColors.kTextColor,
                  ),
                ),
              ),
            ),
            YMargin(15),
            instrument == null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      top: 250,
                      right: 20,
                    ),
                    child: Center(
                      child: Text(
                        "Instrument of ${widget.amount} does not exist",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : instrument.length == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 200),
                        child: Text(
                          "There are no available investments for ${widget.amount}",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: instrument.length,
                          itemBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () {
                                model.check();
                                // selectedIndex = index;
                                paymentViewModel.pickNairaInstrument = instrument[index];
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          child:
                                              model.select ? check : checkEmpty,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            instrument == null
                ? SizedBox()
                : instrument.length == 0
                    ? SizedBox()
                    : RoundedNextButton(
                        onTap: () {
                          print(selectedIndex);
                          Navigator.push(
                            context,
                            HighYieldInvestmentPurchaseSource.route(
                              amount: widget.amount,
                              cards: model.cards,
                            ),
                          );
                        },
                      ),
            YMargin(50)
          ],
        ),
      ),
    );
  }
}
