import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/promissory_note/fixed_income_summary.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class FixedIncomePurchaseSource extends StatefulWidget {
  final double amount;
  final int productId;
  final String uniqueName;
  final String duration;
  final String maturityDate;
  final double rate;
  final int investmentType;
  final int instrumentId;
  final num minimumAmount;
  final String investmentMaturityDate;

  const FixedIncomePurchaseSource({
    Key key,
    this.amount,
    this.productId,
    this.uniqueName,
    this.duration,
    this.maturityDate,
    this.rate,
    this.investmentType,
    this.instrumentId,
    this.minimumAmount,
    this.investmentMaturityDate,
    // this.minimumAmount,
  }) : super(key: key);
  static Route<dynamic> route({
    double amount,
    int productId,
    String uniqueName,
    String duration,
    String maturityDate,
    double rate,
    int minimumAmount,
    int investmentType,
    int instrumentId,
    String investmentMaturityDate,
  }) {
    // print("Duration Purchase Screen $uniqueName");
    return MaterialPageRoute(
      builder: (_) => FixedIncomePurchaseSource(
        amount: amount,
        productId: productId,
        uniqueName: uniqueName,
        maturityDate: maturityDate,
        rate: rate,
        investmentType: investmentType,
        instrumentId: instrumentId,
        minimumAmount: minimumAmount,
        investmentMaturityDate: investmentMaturityDate,
        duration: duration,
      ),
      settings: RouteSettings(
        name: FixedIncomePurchaseSource().toStringShort(),
      ),
    );
  }

  @override
  _FixedIncomePurchaseSourceState createState() =>
      _FixedIncomePurchaseSourceState();
}

class _FixedIncomePurchaseSourceState extends State<FixedIncomePurchaseSource> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<InvestmentHighYieldViewModel>.withConsumer(
      viewModelBuilder: () => InvestmentHighYieldViewModel(),
      builder: (context, model, _) => Scaffold(
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
                onTap: () {
                  Navigator.push(
                    context,
                    SavingsSummaryScreen.route(
                      amount: widget.amount,
                      investmentId: widget.productId,
                      instrumentId: widget.instrumentId,
                      maturityDate: widget.investmentMaturityDate,
                      rate: widget.rate,
                      investmentType: widget.investmentType,
                      bondName: widget.duration,
                      uniqueName: widget.uniqueName,
                      channelId: 1,
                      // intermediaryBankType: 1,
                    ),
                  );
                },
                paymentsource: "Debit Card",
                image: "card",
              ),
              YMargin(25),
              PaymentSourceButton(
                onTap: () {
                  // print(widget.uniqueName);
                  Navigator.push(
                    context,
                    SavingsSummaryScreen.route(
                      amount: widget.amount,
                      investmentId: widget.productId,
                      instrumentId: widget.instrumentId,
                      maturityDate: widget.investmentMaturityDate,
                      rate: widget.rate,
                      investmentType: widget.investmentType,
                      bondName: widget.duration,
                      uniqueName: widget.uniqueName,
                      channelId: 5,
                      // intermediaryBankType: 1,
                    ),
                  );
                },
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
      ),
    );
  }
}
