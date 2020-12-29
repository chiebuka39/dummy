import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/new_screens/withdrawals/add_bank_account.dart';
import 'package:zimvest/new_screens/withdrawals/review_bank_transfer.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class SelectBankAccount extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SelectBankAccount(),
        settings:
        RouteSettings(name: SelectBankAccount().toStringShort()));
  }
  @override
  _SelectBankAccountState createState() => _SelectBankAccountState();
}

class _SelectBankAccountState extends State<SelectBankAccount> {
  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("",
          style: TextStyle(color: Colors.black87,fontSize: 14),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(40),
          Text("Select Bank Account", style: TextStyle(fontFamily: AppStrings.fontBold,
              fontSize: 15,color: AppColors.kTextColor),),

          ...List.generate(paymentViewModel.userBanks.length, (index) {
            Bank bank = paymentViewModel.userBanks[index];
            return BankItemWidget(bank: bank,);
          }),
        Spacer(),
      Center(
        child: PrimaryButtonNew(
          onTap: (){
            Navigator.push(context, AddBankAccScreen.route());
          },
          title: "Add Bank Account",
        ),
      ),
            YMargin(30)

        ],),
      ),
    );
  }
}

class BankItemWidget extends StatelessWidget {
  const BankItemWidget({
    Key key, this.bank,
  }) : super(key: key);

  final Bank bank;

  @override
  Widget build(BuildContext context) {
    ABSPaymentViewModel paymentViewModel = Provider.of(context);
    return GestureDetector(
      onTap: (){
        paymentViewModel.selectedBank = bank;
        Navigator.push(context, ReviewBankTransfer.route());
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
            Text(bank.accountName, style: TextStyle(
              fontFamily: AppStrings.fontMedium
            ),),
            YMargin(20),
            Row(
              children: [
                Text(bank.accountNum, style: TextStyle(fontSize: 12,
                  fontFamily: AppStrings.fontNormal
                ),),
                Spacer(),
                Text(bank.name, style: TextStyle(fontSize: 12,
                  fontFamily: AppStrings.fontNormal
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
