import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/fixed/treasury_bills/fixed_income_summary.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

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
  final int channelId;
  final int intermediaryBankType;
  final List<PaymentCard> cards;
  const FixedIncomePurchaseSource(
      {Key key,
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
      this.channelId,
      this.intermediaryBankType, this.cards})
      : super(key: key);
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
    int channelId,
    int intermediaryBankType,
    List<PaymentCard> cards
  }) {
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
        channelId: channelId,
        intermediaryBankType: intermediaryBankType,
        cards: cards,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return SelectPaymentCardWidget(
                          cards: widget.cards,
                          success: false,
                          navigate: () {
                            Navigator.of(context).push(
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
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        SvgPicture.asset("images/new/card.svg"),
                        XMargin(10),
                        Text(
                          "Debit Card",
                          style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 13,
                              fontFamily: AppStrings.fontNormal),
                        ),
                        Spacer(),
                        Icon(
                          Icons.navigate_next_rounded,
                          color: AppColors.kWhite,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              YMargin(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SelectWallet(
                  onPressed: () {
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
                ),
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
