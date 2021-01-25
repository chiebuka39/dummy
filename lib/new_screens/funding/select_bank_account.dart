import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/funding/withdraw_screen.dart';
import 'package:zimvest/new_screens/withdrawals/add_bank_account.dart';
import 'package:zimvest/new_screens/withdrawals/review_bank_transfer.dart';
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
  final List<Bank> banks;

  const SelectBankAccount(
      {Key key,
      this.banks,
      this.name,
      this.withDrawable,
      this.transactionId,
      this.instrumentId,
      this.isLiquidate})
      : super(key: key);
  static Route<dynamic> route(
      {List<Bank> banks,
      String name,
      double withDrawable,
      int transactionId,
      int instrumentId,
      bool isLiquidate}) {
    return MaterialPageRoute(
        builder: (_) => SelectBankAccount(
              banks: banks,
              name: name,
              withDrawable: withDrawable,
              transactionId: transactionId,
              instrumentId: instrumentId,
              isLiquidate: isLiquidate,
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
        }
      ),
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
                itemCount: widget.banks == null
                    ? 0
                    : widget.banks.length,
                itemBuilder: (context, index) => BankItemWidget(
                  bank: widget.banks[index],
                  isLiquidate: widget.isLiquidate,
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
    this.bank,
    this.isLiquidate,
  }) : super(key: key);

  final Bank bank;
  final bool isLiquidate;
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return GestureDetector(
      onTap: () {
        paymentViewModel.selectedBank = bank;
        if (isLiquidate) {
          Navigator.push(context, ReviewBankTransferLiquidation.route());
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
