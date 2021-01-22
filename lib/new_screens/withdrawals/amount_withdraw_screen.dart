import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/withdrawals/choose_wealth_withdraw_source.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class AmountWithdrawScreen extends StatefulWidget {
  final bool penaltyWithDraw;
  const AmountWithdrawScreen({
    Key key, this.penaltyWithDraw = false,
  }) : super(key: key);
  static Route<dynamic> route({bool penaltyWithDraw = false}) {
    return MaterialPageRoute(
        builder: (_) => AmountWithdrawScreen(penaltyWithDraw: penaltyWithDraw,),
        settings:
        RouteSettings(name: AmountWithdrawScreen().toStringShort()));
  }

  @override
  _SavingDailyScreenState createState() => _SavingDailyScreenState();
}

class _SavingDailyScreenState extends State<AmountWithdrawScreen> with AfterLayoutMixin<AmountWithdrawScreen> {

  
  ABSSavingViewModel savingViewModel;
  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) {
    paymentViewModel.getCustomerBank(identityViewModel.user.token);
    savingViewModel.getWithdrawalChannel(token:identityViewModel.user.token);
  }


  @override
  Widget build(BuildContext context) {
    savingViewModel =   Provider.of(context);
    identityViewModel = Provider.of(context);
    paymentViewModel =  Provider.of(context);
    ABSPinViewModel pinViewModel = Provider.of(context);
    double height = MediaQuery.of(context).size.height;
    print(height);
    return GestureDetector(
      onTap: (){

        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: ZimAppBar(
          icon: Icons.arrow_back_ios_outlined,
          callback: (){
            pinViewModel.resetAmount();
            Navigator.pop(context);
          },
          showCancel: true,
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
                Text("How much do you want to withdraw?", style: TextStyle(fontSize: 15,
                    color: AppColors.kGreyText,
                    fontFamily: AppStrings.fontBold),),
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
                      child: Text(convertWithComma(pinViewModel.amount), style: TextStyle(fontSize: 15),)),
                ),
                if (widget.penaltyWithDraw) Padding(
                  padding: const EdgeInsets.only(right: 40,top: 10),
                  child: Text("You would be charged 10% of your accrued interest for "
                      "liquidating outside of your accrued date", style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontMedium, height: 1.6),),
                ) else SizedBox(),
                YMargin(height > 750 ? 65:30),


                RoundedNextButton(
                  onTap: pinViewModel.amount.isEmpty? null : double.parse(pinViewModel.amount) < 1000 ? null: (){
                    if(double.parse(pinViewModel.amount) > savingViewModel.selectedPlan.amountSaved){
                        AppUtils.showError(context, message: "You don't Have up to this amount on this plan", title: "Large Amount");
                    }else{
                      savingViewModel.amountToSave = double.parse(pinViewModel.amount);
                      Navigator.push(context, ChooseWealthWithdrawScreen.route());
                      pinViewModel.resetAmount();
                    }

                  },
                ),
                YMargin(height > 750 ? 65:25),
                NumKeyboardWidget()



              ],),
          ),
        ),
      ),
    );
  }

  convertWithComma(String newValue){
    String value = newValue;
    var buffer = new StringBuffer();

    if(value.length == 4){
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
    }else if(value.length == 5){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
    }else if(value.length == 6){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
    }else if(value.length == 7){
      buffer.write(value[0]);
      buffer.write(',');
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(',');
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(value[6]);
    }else if(value.length == 8){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(',');
      buffer.write(value[2]);
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(',');
      buffer.write(value[5]);
      buffer.write(value[6]);
      buffer.write(value[7]);
    }else if(value.length == 9){
      buffer.write(value[0]);
      buffer.write(value[1]);
      buffer.write(value[2]);
      buffer.write(',');
      buffer.write(value[3]);
      buffer.write(value[4]);
      buffer.write(value[5]);
      buffer.write(',');
      buffer.write(value[6]);
      buffer.write(value[7]);
      buffer.write(value[8]);
    }
    else{
      for (int i = 0; i < value.length; i++) {
        print('lllllf $i');
        buffer.write(value[i]);
        var nonZeroIndex = i + 1;

        if (nonZeroIndex % 3 == 0 && nonZeroIndex != value.length) {
          buffer.write(',');
        }

      }
    }

    return buffer.toString();

  }
}