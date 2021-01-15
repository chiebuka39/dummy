import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/naira/investment_summary.dart';
import 'package:zimvest/new_screens/navigation/investments/widgets/card_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class HighYieldInvestmentPurchaseSource extends StatefulWidget {
  final double amount;
  final int productId;
  final String uniqueName;
  final int duration;
  final String maturityDate;
  final double rate;
  final List<PaymentCard> cards;

  const HighYieldInvestmentPurchaseSource(
      {Key key,
      this.amount,
      this.productId,
      this.uniqueName,
      this.duration,
      this.maturityDate,
      this.rate,
      this.cards})
      : super(key: key);
  static Route<dynamic> route(
      {double amount,
      int productId,
      String uniqueName,
      int duration,
      String maturityDate,
      double rate,
      List<PaymentCard> cards}) {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentPurchaseSource(
        amount: amount,
        uniqueName: uniqueName,
        maturityDate: maturityDate,
        rate: rate,
        cards: cards,
        duration: duration,
        productId: productId,
      ),
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
                              InvestmentSummaryScreenNaira.route(
                                channelId: 1,
                                productId: widget.productId,
                                amount: widget.amount,
                                uniqueName: widget.uniqueName,
                                maturityDate: widget.maturityDate,
                                rate: widget.rate,
                                duration: widget.duration
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
                    print(widget.duration);
                    Navigator.push(
                      context,
                      InvestmentSummaryScreenNaira.route(
                        channelId: 5,
                        productId: widget.productId,
                        duration: widget.duration,
                        amount: widget.amount,
                        uniqueName: widget.uniqueName,
                        maturityDate: widget.maturityDate,
                        rate: widget.rate,
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
