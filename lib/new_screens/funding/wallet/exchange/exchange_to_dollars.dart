import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/funding/wallet/wallet_withdraw_to.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class WalletWithdrawToScreenDollar extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WalletWithdrawToScreenDollar(),
        settings:
            RouteSettings(name: WalletWithdrawToScreenDollar().toStringShort()));
  }

  @override
  _WalletWithdrawToScreenState createState() => _WalletWithdrawToScreenState();
}

class _WalletWithdrawToScreenState extends State<WalletWithdrawToScreenDollar>
    with AfterLayoutMixin<WalletWithdrawToScreenDollar> {
  ABSIdentityViewModel identityViewModel;
  ABSPaymentViewModel paymentViewModel;
  @override
  void afterFirstLayout(BuildContext context) {
    paymentViewModel.getCustomerBank(identityViewModel.user.token);
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before_rounded,
            color: AppColors.kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where do you want to withdraw to ?",
              style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),
            ),
            YMargin(53),

            WithdrawAction(
              bg: AppColors.kSecondaryColor,
              title: "Bank Account",
              onTap: () {
                Navigator.push(
                    context, SelectBankAccount.route(nairaWithdrawal: true));
              },
            ),
            YMargin(20),
          ],
        ),
      ),
    );
  }
}
