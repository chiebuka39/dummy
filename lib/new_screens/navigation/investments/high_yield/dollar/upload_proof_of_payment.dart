import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/investment_summary_high_yield_dollar.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class UploadProofOfPayment extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => UploadProofOfPayment(),
      settings: RouteSettings(
        name: UploadProofOfPayment().toStringShort(),
      ),
    );
  }

  @override
  _UploadProofOfPaymentState createState() => _UploadProofOfPaymentState();
}

class _UploadProofOfPaymentState extends State<UploadProofOfPayment> {
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(69),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Proof Payment",
              style: TextStyle(
                fontSize: 15,
                fontFamily: AppStrings.fontBold,
                color: AppColors.kTextColor,
              ),
            ),
          ),
          YMargin(51),
          PaymentSourceButtonSpecial(
            paymentsource: "Upload Proof of Payment",
            color: AppColors.kTextColor,
            onTap: (){
              Navigator.push(context, InvestmentSummaryScreenDollarWired.route());
            },
          ),
        ],
      ),
    );
  }
}
