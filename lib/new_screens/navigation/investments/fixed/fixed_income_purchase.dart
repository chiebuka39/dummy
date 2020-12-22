import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/fixed_income_summary.dart';
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
  final String rate;
  // final String minimumAmount;

  const FixedIncomePurchaseSource({
    Key key,
    this.amount,
    this.productId,
    this.uniqueName,
    this.duration,
    this.maturityDate,
    this.rate,
    // this.minimumAmount,
  }) : super(key: key);
  static Route<dynamic> route({
    double amount,
    int productId,
    String uniqueName,
    String duration,
    String maturityDate,
    String rate,
    String minimumAmount,
  }) {
    return MaterialPageRoute(
      builder: (_) => FixedIncomePurchaseSource(
        amount: amount,
        productId: productId,
        uniqueName: uniqueName,
        maturityDate: maturityDate,
        rate: rate,
        // minimumAmount: minimumAmount,
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
                  // print("hmmm");
                  // Navigator.push(context, InvestmentSummaryScreenNaira.route());
                },
                paymentsource: "Debit Card",
                image: "card",
              ),
              YMargin(25),
              PaymentSourceButton(
                onTap: () {
                  Navigator.push(context, SavingsSummaryScreen.route());
                  // Navigator.push(
                  //   context,
                    // InvestmentSummaryScreenNaira.route(;
                  //     channelId: 5,
                  //     productId: widget.productId,
                  //     duration: widget.duration,
                  //     amount: widget.amount,
                  //     uniqueName: widget.uniqueName,
                  //     maturityDate: widget.maturityDate,
                  //     rate: widget.rate,
                  //     minimumAmount: widget.minimumAmount,
                  //   ),
                  // );
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
