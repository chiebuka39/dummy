import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/investment_summary_high_yield_dollar.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/payment_source_wired_transfer.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class HighYieldInvestmentDollarPurchaseSource extends StatefulWidget {
  final String uniqueName;
  final int id;
  final String duration;
  final String maturityDate;
  final String rate;
  final String minimumAmount;
  final String maximumAmount;
  final String amount;

  const HighYieldInvestmentDollarPurchaseSource(
      {Key key,
      this.uniqueName,
      this.id,
      this.duration,
      this.maturityDate,
      this.rate,
      this.minimumAmount,
      this.maximumAmount,
      this.amount})
      : super(key: key);
  static Route<dynamic> route(
      {String uniqueName,
      int id,
      String duration,
      String maturityDate,
      String rate,
      String minimumAmount,
      String maximumAmount,
      String amount}) {
    return MaterialPageRoute(
      builder: (_) => HighYieldInvestmentDollarPurchaseSource(
        uniqueName: uniqueName,
        id: id,
        maturityDate: maturityDate,
        rate: rate,
        minimumAmount: minimumAmount,
        maximumAmount: maximumAmount,
        amount: amount,
      ),
      settings: RouteSettings(
        name: HighYieldInvestmentDollarPurchaseSource().toStringShort(),
      ),
    );
  }

  @override
  _HighYieldInvestmentDollarPurchaseSourceState createState() =>
      _HighYieldInvestmentDollarPurchaseSourceState();
}

class _HighYieldInvestmentDollarPurchaseSourceState
    extends State<HighYieldInvestmentDollarPurchaseSource> {
  bool isNaira = true;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(69),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 76),
            child: Text(
              "Choose Funding Option",
              style: TextStyle(
                fontSize: 17,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          verticalSpace(52),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                width: screenWidth(context),
                height: 40,
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      left: isNaira == true ? screenWidth(context) / 2 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        width: screenWidth(context) / 2,
                        height: 40,
                        decoration: BoxDecoration(
                            // color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(13)),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                isNaira = !isNaira;
                              });
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Naira",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isNaira == true
                                            ? AppColors.kPrimaryColor
                                            : AppColors.kLightText4),
                                  ),
                                  Container(
                                    height: screenWidth(context) / 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isNaira == true
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              setState(() {
                                isNaira = !isNaira;
                              });
                            },
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Dollar",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: isNaira == false
                                            ? AppColors.kPrimaryColor
                                            : AppColors.kLightText4),
                                  ),
                                  Container(
                                    height: screenWidth(context) / 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isNaira == false
                                          ? AppColors.kPrimaryColor
                                          : AppColors.kWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          isNaira == true
              ? Expanded(child: NairaPage())
              : Expanded(child: DollarPage())
        ],
      ),
    );
  }
}

class NairaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          YMargin(25),
          PaymentSourceButton(
            paymentsource: "Naira Wallet",
            image: "wallet",
            amount: "${AppStrings.nairaSymbol}30,000,000",
            color: AppColors.kTextColor,
            onTap: () =>
                Navigator.push(context, InvestmentSummaryScreenDollar.route()),
          ),
        ],
      ),
    );
  }
}

class DollarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        YMargin(25),
        PaymentSourceButton(
          paymentsource: "Dollar Wallet",
          image: "wallet",
          amount: "${AppStrings.dollarSymbol}30,000,000",
          color: AppColors.kTextColor,
          onTap: () =>
              Navigator.push(context, InvestmentSummaryScreenDollar.route()),
        ),
        YMargin(25),
        PaymentSourceButtonSpecial(
          paymentsource: "Wired Transfer",
          image: "wallet",
          onTap: () => Navigator.push(context, WiredTransferScreen.route()),
        ),
        YMargin(25),
        PaymentSourceButtonSpecial(
          paymentsource: "R|rexelpay",
          color: AppColors.kHighYield,
          onTap: null,
        ),
      ],
    ));
  }
}
