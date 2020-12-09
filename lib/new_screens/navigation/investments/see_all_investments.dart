import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/strings.dart';

class AllNairaInvestments extends StatefulWidget {
  final String title;

  static Route<dynamic> route(String be) {
    return MaterialPageRoute(
      builder: (_) => AllNairaInvestments(title: be),
      settings: RouteSettings(
        name: AllNairaInvestments().toStringShort(),
      ),
    );
  }

  const AllNairaInvestments({Key key, this.title}) : super(key: key);
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
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: InvestmentCardNaira(
            height: 5,
            investmentDuration: widget.title,
            percentage: "6.67",
            minimumAmount: "5,000,000",
            maximumAmount: "50,000,000",
          ),
        ),
        itemCount: 13,
      ),
    );
  }
}


class AllDollarInvestments extends StatefulWidget {
  final String title;

  static Route<dynamic> route(String be) {
    return MaterialPageRoute(
      builder: (_) => AllDollarInvestments(title: be),
      settings: RouteSettings(
        name: AllDollarInvestments().toStringShort(),
      ),
    );
  }

  const AllDollarInvestments({Key key, this.title}) : super(key: key);
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
          "Zimvest High Yield Dollar ${widget.title} Days",
          style: TextStyle(
              fontSize: 13,
              fontFamily: AppStrings.fontMedium,
              color: AppColors.kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: InvestmentCardNaira(
            height: 5,
            investmentDuration: widget.title,
            percentage: "6.67",
            minimumAmount: "5,000,000",
            maximumAmount: "50,000,000",
          ),
        ),
        itemCount: 13,
      ),
    );
  }
}