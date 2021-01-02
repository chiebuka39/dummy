import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/funding/confirm_withdrawal.dart';
import 'package:zimvest/new_screens/funding/savings_summary.dart';
import 'package:zimvest/new_screens/funding/select_bank_account.dart';
import 'package:zimvest/new_screens/withdrawals/review_wallet_transfer.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class ChooseWealthWithdrawScreen extends StatefulWidget {
  const ChooseWealthWithdrawScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ChooseWealthWithdrawScreen(),
        settings:
        RouteSettings(name: ChooseWealthWithdrawScreen().toStringShort()));
  }

  @override
  _ChooseWealthWithdrawScreenState createState() => _ChooseWealthWithdrawScreenState();
}

class _ChooseWealthWithdrawScreenState extends State<ChooseWealthWithdrawScreen> {



  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          callback: (){
            Navigator.pop(context);
          },
          text: "Withdraw",
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(40),
                Text("Choose Withdrawal Destination?", style: TextStyle(fontSize: 15,
                    color: AppColors.kGreyText,
                    fontFamily: AppStrings.fontBold),),
                YMargin(50),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(SelectBankAccount.route());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(children: [
                      SvgPicture.asset("images/new/card.svg"),
                      XMargin(10),
                      Text("Bank Account", style: TextStyle(color: AppColors.kWhite,
                          fontSize: 13,fontFamily: AppStrings.fontNormal),),
                      Spacer(),
                      Icon(Icons.navigate_next_rounded,color: AppColors.kWhite,)
                    ],),
                  ),
                ),
                YMargin(25),
                SelectWallet(onPressed: () {
                  Navigator.of(context).push(ReviewWalletTransfer.route());
                },

                ),
                YMargin(5),




              ],),
          ),
        ),
      ),
    );
  }
}