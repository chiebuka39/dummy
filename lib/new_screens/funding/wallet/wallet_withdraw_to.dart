import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/confirm_withdrawal.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/funding/wallet/pick_investment_plan.dart';
import 'package:zimvest/new_screens/funding/wallet/pick_savings_plan.dart';
import 'package:zimvest/new_screens/withdrawals/use_pin_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class WalletWithdrawToScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WalletWithdrawToScreen(),
        settings:
            RouteSettings(name: WalletWithdrawToScreen().toStringShort()));
  }

  @override
  _WalletWithdrawToScreenState createState() => _WalletWithdrawToScreenState();
}

class _WalletWithdrawToScreenState extends State<WalletWithdrawToScreen> with AfterLayoutMixin<WalletWithdrawToScreen> {
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
              onTap: () {
                Navigator.push(
                  context,
                  PickSavingsPlanSceen.route(),
                );
              },
            ),
            WithdrawAction(
              bg: AppColors.kSecondaryColor,
              title: "Bank Account",
              onTap: () {

                Navigator.push(context, SelectBankAccount.route(nairaWithdrawal: true));
              },
            ),
            YMargin(20),

          ],
        ),
      ),
    );
  }
}

class WithdrawAction extends StatelessWidget {
  const WithdrawAction({
    Key key,
    this.title = "Savings Plan",
    this.onTap,
    this.bg = AppColors.kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String title;
  final Color bg;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 55,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontFamily: AppStrings.fontNormal),
            ),
            Spacer(),
            Icon(
              Icons.navigate_next_rounded,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }
}
