import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/commercial_paper/review_liquidation_cp.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/coporate_bond/review_liquidation_cb.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/euro_bond/review_liquidation_eb.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/fgnbond/review_liquidation_fgb.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/promissorynote/review_liquidation_pn.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/fixed_income/treasury_bills/review_liquidation_tbills.dart';
import 'package:zimvest/new_screens/navigation/wealth/liquidate_asset/high_yield/dollar/review_high_yield_dollar_liduidation.dart';
import 'package:zimvest/new_screens/withdrawals/add_bank_account.dart';
import 'package:zimvest/new_screens/withdrawals/review_bank_transfer.dart';
import 'package:zimvest/new_screens/withdrawals/withdraw_to_%20savings.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/margins.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';


class SelectBankAccount extends StatefulWidget {
  final String name;
  final double withDrawable;
  final int transactionId;
  final int instrumentId;
  final bool isLiquidate;
  final bool nairaWithdrawal;
  final List<Bank> banks;
  final int investmentType;

  const SelectBankAccount(
      {Key key,
      this.banks,
      this.name,
      this.withDrawable,
      this.transactionId,
      this.instrumentId,
      this.nairaWithdrawal,
      this.isLiquidate,
      this.investmentType})
      : super(key: key);
  static Route<dynamic> route(
      {List<Bank> banks,
      String name,
      double withDrawable,
      int transactionId,
      int instrumentId,
      bool isLiquidate,
      bool nairaWithdrawal,
      int investmentType}) {
    return MaterialPageRoute(
        builder: (_) => SelectBankAccount(
              banks: banks,
              name: name,
              withDrawable: withDrawable,
              transactionId: transactionId,
              instrumentId: instrumentId,
              isLiquidate: isLiquidate,
              nairaWithdrawal: nairaWithdrawal,
              investmentType: investmentType,
            ),
        settings: RouteSettings(name: SelectBankAccount().toStringShort()));
  }

  @override
  _SelectBankAccountState createState() => _SelectBankAccountState();
}

class _SelectBankAccountState extends State<SelectBankAccount> {
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          text: "",
          showCancel: true,
          callback: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(40),
            Text(
              "Select Bank Account",
              style: TextStyle(
                  fontFamily: AppStrings.fontBold,
                  fontSize: 15,
                  color: AppColors.kTextColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: paymentViewModel.userBanks == null
                    ? 0
                    : paymentViewModel.userBanks.length,
                itemBuilder: (context, index) => BankItemWidget(
                  bank: paymentViewModel.userBanks[index],
                  isLiquidate: widget.isLiquidate,
                  isWithdraw: widget.nairaWithdrawal,
                ),
              ),
            ),
            Spacer(),
            Center(
              child: PrimaryButtonNew(
                onTap: () {
                  Navigator.push(context, AddBankAccScreen.route());
                },
                title: "Add Bank Account",
              ),
            ),
            YMargin(30)
          ],
        ),
      ),
    );
  }
}

class BankItemWidget extends StatelessWidget {
  const BankItemWidget({
    Key key,
    this.isLiquidate,
    this.isWithdraw = false,
    this.bank,
    this.investmentType,
  }) : super(key: key);

  final Bank bank;
  final bool isLiquidate;
  final int investmentType;
  final bool isWithdraw;
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    print("pmnn ${bank.accountName}");
    return GestureDetector(
      onTap: () {
        paymentViewModel.selectedBank = bank;
        if (isWithdraw) {
          Navigator.push(context, WithdrawToSavingsScreen.route(bank: bank, isDollar: true));
        } else if (isLiquidate) {
          if (isLiquidate && investmentType == 0) {
            Navigator.push(context, ReviewBankTransferLiquidation.route());
          }
          if (isLiquidate && investmentType == 1) {
            Navigator.push(
                context, ReviewBankTransferLiquidationTreasuryBills.route());
          }
          if (isLiquidate && investmentType == 2) {
            Navigator.push(
                context, ReviewBankTransferLiquidationCommercialPaper.route());
          }
          if (isLiquidate && investmentType == 3) {
            Navigator.push(
                context, ReviewBankTransferLiquidationEuroBond.route());
          }
          if (isLiquidate && investmentType == 4) {
            Navigator.push(
                context, ReviewBankTransferLiquidationFGNBond.route());
          }
          if (isLiquidate && investmentType == 5) {
            Navigator.push(
                context, ReviewBankTransferLiquidationPromissoryNote.route());
          }
          if (isLiquidate && investmentType == 6) {
            Navigator.push(
                context, ReviewBankTransferLiquidationCorporateBond.route());
          }

          if (isLiquidate && investmentType == 7) {
            Navigator.push(
                context, ReviewBankTransferHighYieldDollarLiquidation.route());
          }
        } else {
          Navigator.push(context, ReviewBankTransfer.route());
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 30),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: AppUtils.getBoxShaddow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(60),
            Text(
              bank.accountName,
              style: TextStyle(fontFamily: AppStrings.fontMedium),
            ),
            YMargin(20),
            Row(
              children: [
                Text(
                  bank.accountNum,
                  style: TextStyle(
                      fontSize: 12, fontFamily: AppStrings.fontNormal),
                ),
                Spacer(),
                Text(
                  bank.name,
                  style: TextStyle(
                      fontSize: 12, fontFamily: AppStrings.fontNormal),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
