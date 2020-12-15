import 'package:flutter/material.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_details_naira.dart';
import 'package:zimvest/new_screens/navigation/investments/see_all_investments.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

class HighYieldNairaScreen extends StatefulWidget {
  final List<TermInstrument> instrument;

  const HighYieldNairaScreen({Key key, this.instrument}) : super(key: key);
  @override
  _HighYieldNairaScreenState createState() => _HighYieldNairaScreenState();
}

class _HighYieldNairaScreenState extends State<HighYieldNairaScreen> {
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
          print(instrumentNames[index]);
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
                            AllNairaInvestments.route(
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
                                    HighYieldDetails.route(
                                        "${instrumentNames[index]}"),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: InvestmentCardNaira(
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
