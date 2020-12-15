import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/investment_summary.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldInvestmentPurchaseSource extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentPurchaseSource(),
      settings: RouteSettings(
        name: HighYieldInvestmentPurchaseSource().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldInvestmentPurchaseSourceState createState() =>
      _HighYieldInvestmentPurchaseSourceState();
}

class _HighYieldInvestmentPurchaseSourceState
    extends State<HighYieldInvestmentPurchaseSource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
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
            onPressed: () => Navigator.pop(context)),
      ),
      body: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(69),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 76),
              child: Text(
                "Choose Funding Source",
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: AppStrings.fontBold,
                  color: AppColors.kTextColor,
                ),
              ),
            ),
            verticalSpace(52),
            PaymentSourceButton(
              onTap: (){
                print("hmmm");
                Navigator.push(context, InvestmentSummaryScreenNaira.route());
              },
              paymentsource: "Debit Card",
              image: "card",
            ),
            YMargin(25),
            PaymentSourceButton(
              onTap: () => Navigator.push(context, InvestmentSummaryScreenNaira.route()),
              paymentsource: "Wallet",
              image: "wallet",
              amount: "${AppStrings.nairaSymbol}30,000,000",
              color: AppColors.kTextColor,
            ),
            YMargin(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Funding with your Zimvest Wallet is totally free",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: AppStrings.fontLight,
                  color: AppColors.kTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
