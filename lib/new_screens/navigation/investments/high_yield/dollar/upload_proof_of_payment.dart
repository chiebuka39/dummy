import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/data/view_models/wallets_view_model.dart';
import 'package:zimvest/new_screens/funding/wallet/dollar/fund_dollar_wallet_summary.dart';
import 'package:zimvest/new_screens/navigation/investments/high_yield/dollar/investment_summary_high_yield_dollar.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

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
  ABSPaymentViewModel paymentViewModel;
  WalletViewModel walletModel;
  InvestmentHighYieldViewModel investmentModel;
  @override
  Widget build(BuildContext context) {
    paymentViewModel = Provider.of(context);
    walletModel = Provider.of(context);
    investmentModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        text: "Invest",
        callback: () {
          Navigator.pop(context);
        },
        icon: Icons.arrow_back_ios,
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
            onTap: () async {
              if (paymentViewModel.conversionRate == null) {
                await investmentModel.pickImage();
                Navigator.push(
                    context,
                    InvestmentSummaryScreenDollarWired.route(
                        pickedImage: investmentModel.pickedImage));
              } else {
                print("zoom");
                await investmentModel.pickImage();
                Navigator.push(
                  context,
                  FundDollarWalletSummaryScreen.route(
                    image: investmentModel.pickedImage,
                      amount: paymentViewModel.investmentAmount,
                      nairaRate: paymentViewModel.conversionRate,
                      isWallet: false,
                      balance: paymentViewModel.wallet
                          .where((element) => element.currency == "NGN")
                          .first
                          .balance),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
