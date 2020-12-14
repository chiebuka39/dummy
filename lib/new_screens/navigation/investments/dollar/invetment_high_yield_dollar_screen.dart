import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/dollar/high_yield_investment_details_dollars.dart';
import 'package:zimvest/new_screens/navigation/investments/see_all_investments.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class HighYieldDollarScreen extends StatefulWidget {
  final List<TermInstrument> instrument;

  const HighYieldDollarScreen({Key key, this.instrument}) : super(key: key);
  @override
  _HighYieldDollarScreenState createState() => _HighYieldDollarScreenState();
}

class _HighYieldDollarScreenState extends State<HighYieldDollarScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> instrumentNames =
        widget.instrument.map((e) => e.instrumentName).toSet().toList();
    instrumentNames.sort((a, b) =>
        int.tryParse(a.split(" ")[0]) > int.tryParse(b.split(" ")[0]) ? 1 : -1);
    return Expanded(
      child: ListView.builder(
        itemCount: instrumentNames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${instrumentNames[index]}",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: AppStrings.fontMedium,
                          color: AppColors.kTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            AllDollarInvestments.route(
                                "${instrumentNames[index]}"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: AppStrings.fontMedium,
                                color: AppColors.kPrimaryColor),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: AppColors.kPrimaryColor)
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView(
                          children: widget.instrument
                              .where((element) =>
                                  element.instrumentName ==
                                  instrumentNames[index])
                              .map(
                                (e) => GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    HighYieldDetailsDollar.route(
                                        "${instrumentNames[index]}"),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: InvestmentCardDollar(
                                      investmentDuration: e.instrumentName,
                                      maximumAmount: e.maximumAmount,
                                      minimumAmount: e.minimumAmount,
                                      percentage: e.depositRate,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
