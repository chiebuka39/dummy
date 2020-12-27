import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/new_screens/funding/confirm_withdrawal.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/funding/wallet/pick_investment_plan.dart';
import 'package:zimvest/new_screens/funding/wallet/pick_savings_plan.dart';
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

class _WalletWithdrawToScreenState extends State<WalletWithdrawToScreen> {
  @override
  Widget build(BuildContext context) {
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
                  PickSavingsPlanSceen.route(
                    aspirePlans: List.generate(
                      5,
                      (index) => SavingPlanModel(
                        id: 2,
                        productId: 45,
                        productName: "Ijele",
                        planName: "Palliative",
                        savingsType: 3,
                        savingsFrequency: 2,
                        savingsFrequencyText: "Monthly",
                        savingsAmount: 300000.00,
                        targetAmount: 120000000.00,
                        startDate: DateTime.now(),
                        status: 1,
                        statusText: "Active",
                        isMatured: false,
                        amountSaved: 90000000.00,
                        accruedInterest: 30000.00,
                        interestRate: 3.00,
                        successRate: "80",
                        dateCreated: DateTime.now(),
                        dateUpdated: DateTime.now(),
                        isPaused: false,
                      ),
                    ),
                  ),
                );
              },
            ),
            WithdrawAction(
              bg: AppColors.kSecondaryColor,
              title: "Investment Plan",
              onTap: () {
                Navigator.push(context, PickInvestmentPlan.route());
              },
            ),
            YMargin(20),
            Center(
              child: Text("Or"),
            ),
            WithdrawAction(
              title: "Bank Account",
              bg: AppColors.kPrimaryColorLight,
              textColor: AppColors.kPrimaryColor,
              onTap: () {
                Navigator.push(context, SelectBankAccount.route());
              },
            )
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
