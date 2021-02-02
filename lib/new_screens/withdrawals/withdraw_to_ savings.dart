import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/funding/choose_funding_source.dart';
import 'package:zimvest/new_screens/funding/savings_summary.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/choose_start_screen.dart';
import 'package:zimvest/new_screens/withdrawals/review_bank_transfer.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class WithdrawToSavingsScreen extends StatefulWidget {
  final SavingPlanModel savingPlanModel;
  final Bank bank;
  final bool isDollar;
  const WithdrawToSavingsScreen({
    Key key, this.savingPlanModel, this.bank, this.isDollar,
  }) : super(key: key);
  static Route<dynamic> route({SavingPlanModel savingPlanModel,Bank bank, bool isDollar}) {
    return MaterialPageRoute(
        builder: (_) => WithdrawToSavingsScreen(savingPlanModel: savingPlanModel,bank: bank, isDollar: isDollar),
        settings:
        RouteSettings(name: WithdrawToSavingsScreen().toStringShort()));
  }

  @override
  _WithdrawToSavingsScreenState createState() => _WithdrawToSavingsScreenState();
}

class _WithdrawToSavingsScreenState extends State<WithdrawToSavingsScreen> {

  String amount = "";
  ABSSavingViewModel savingViewModel;
  ABSPaymentViewModel paymentViewModel;
  ABSPinViewModel pinViewModel;


  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    pinViewModel = Provider.of(context);
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          text: 'Top Up',
          showCancel: true,
          callback: (){
            pinViewModel.resetAmount();
            Navigator.pop(context);
          },
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
                SizedBox(
                  width: 250,
                  child: Text( widget.bank == null ? "How much would you like to save ${widget.savingPlanModel.productName}?":"How much do you went to send to ${widget.bank.accountName}", style: TextStyle(fontSize: 15,
                      color: AppColors.kGreyText,
                      fontFamily: AppStrings.fontBold, height: 1.6),),
                ),
                YMargin(12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kGreyBg,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child:pinViewModel.amount.isEmpty ? Text("Enter Amount", style: TextStyle(fontFamily: AppStrings.fontNormal,
                          fontSize: 14, color: AppColors.kTextColor.withOpacity(0.8)),): Text(pinViewModel.amount.convertWithComma(), style: TextStyle(fontSize: 15),)),
                ),
                YMargin(10),

                SizedBox(
                  width: 300,
                  child: Text("N/B Topup must be at least 1,000 naira", style: TextStyle(
                      fontSize: 10,height: 1.6,color: AppColors.kRed),),
                ),
                YMargin(height < 650 ? 25:height > 700 ? 70:40),


                RoundedNextButton(
                  onTap: pinViewModel.amount.isEmpty? null : double.parse(pinViewModel.amount) < 1000 ? null: (){
                    savingViewModel.amountToSave = double.parse(pinViewModel.amount);
                    if(widget.savingPlanModel != null){
                      savingViewModel.selectedPlan = widget.savingPlanModel;
                      Navigator.of(context).push(SavingsSummaryScreen.route(
                          amount: savingViewModel.amountToSave));
                    }else if(widget.bank != null && widget.isDollar){
                      print("Lmao");
                      Navigator.of(context).push(ReviewBankTransferDollar.route(
                          nairaWalletWithdrawal: false,bank:widget.bank));
                    }else if(widget.bank != null){
                      print("Nawa oooo");
                      Navigator.of(context).push(ReviewBankTransfer.route(
                          nairaWalletWithdrawal: true,bank:widget.bank));
                    }
                  },
                ),
                YMargin(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Wallet Balance ", style: TextStyle(fontFamily: AppStrings.fontNormal),),
                    Text(AppStrings.nairaSymbol),

                    Text(paymentViewModel.wallet.first.balance.toString().split(".").first.convertWithComma(),
                      style: TextStyle(fontFamily: AppStrings.fontMedium),),
                  ],
                ),
                YMargin(height < 650 ? 15: height > 700 ? 65:30),
                NumKeyboardWidget()



              ],),
          ),
        ),
      ),
    );
  }

  DateTime getDate(){
    DateTime now = DateTime.now();
    List<DateTime> quaters = [DateTime(now.year,1),DateTime(now.year,4),
      DateTime(now.year,7),DateTime(now.year,10)];
    print(",,,,,,,,ooooo ${quaters.where((element) => element.microsecondsSinceEpoch >= now.microsecondsSinceEpoch)}");
    return quaters.where((element) => element.microsecondsSinceEpoch >= now.microsecondsSinceEpoch).first;
  }


}