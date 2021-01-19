import 'package:flutter/material.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/high_yield_investment_details_dollars.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/high_yield_investment_details_naira.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

class AllNairaInvestments extends StatefulWidget {
  final String title;
  final List<TermInstrument> instrument;

  static Route<dynamic> route({String title, List<TermInstrument> instrument}) {
    return MaterialPageRoute(
      builder: (_) => AllNairaInvestments(
        title: title,
        instrument: instrument,
      ),
      settings: RouteSettings(
        name: AllNairaInvestments().toStringShort(),
      ),
    );
  }

  const AllNairaInvestments({Key key, this.title, this.instrument})
      : super(key: key);
  @override
  _AllNairaInvestmentsState createState() => _AllNairaInvestmentsState();
}

class _AllNairaInvestmentsState extends State<AllNairaInvestments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Zimvest High Yield Naira ${widget.title} Days",
          style: TextStyle(
              fontSize: 13,
              fontFamily: AppStrings.fontMedium,
              color: AppColors.kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: widget.instrument
            .where((element) => element.instrumentName == widget.title)
            .map(
              (e) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  HighYieldDetails.route(),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InvestmentCardNaira(
                    height: 4.5,
                    investmentDuration: e.instrumentName,
                    maximumAmount: e.maximumAmount,
                    minimumAmount: e.minimumAmount,
                    percentage: e.depositRate,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AllDollarInvestments extends StatefulWidget {
  final String title;
  final List<TermInstrument> instrument;

  static Route<dynamic> route({String title, List<TermInstrument> instrument}) {
    return MaterialPageRoute(
      builder: (_) => AllDollarInvestments(
        title: title,
        instrument: instrument,
      ),
      settings: RouteSettings(
        name: AllDollarInvestments().toStringShort(),
      ),
    );
  }

  const AllDollarInvestments({Key key, this.title, this.instrument})
      : super(key: key);
  @override
  _AllDollarInvestmentsState createState() => _AllDollarInvestmentsState();
}

class _AllDollarInvestmentsState extends State<AllDollarInvestments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Zimvest High Yield Dollar ${widget.title}",
          style: TextStyle(
              fontSize: 13,
              fontFamily: AppStrings.fontMedium,
              color: AppColors.kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: widget.instrument
            .where((element) => element.instrumentName == widget.title)
            .map(
              (e) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  HighYieldDetailsDollar.route(),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InvestmentCardDollar(
                    height: 4.5,
                    investmentDuration: e.instrumentName,
                    maximumAmount: e.maximumAmount,
                    minimumAmount: e.minimumAmount,
                    percentage: e.depositRate,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
