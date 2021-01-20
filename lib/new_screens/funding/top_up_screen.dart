import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/payment_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/new_screens/funding/choose_funding_source.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => TopUpScreen(),
        settings:
        RouteSettings(name: TopUpScreen().toStringShort()));
  }

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> with AfterLayoutMixin<TopUpScreen> {
  
  ABSSavingViewModel savingViewModel;
  ABSPaymentViewModel paymentViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) {
    paymentViewModel.getUserCards(identityViewModel.user.token);
    savingViewModel.getFundingChannel(token:identityViewModel.user.token);
  }

  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    paymentViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    ABSPinViewModel pinViewModel = Provider.of(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(

        appBar: ZimAppBar(callback: (){
          Navigator.pop(context);
        },icon: Icons.arrow_back_ios_outlined,text: "Top Up",),
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
                Text("How much do you want to add?", style: TextStyle(fontSize: 15,
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
                YMargin(10),
                SizedBox(
                  width: 300,
                  child: Text("You can always top up your savings anytime "
                      "once you create this savings plan", style: TextStyle(
                      fontSize: 10,height: 1.6),),
                ),
                YMargin(3),
                SizedBox(
                  width: 300,
                  child: Text("N/B Savings must be at least 1,000 naira", style: TextStyle(
                      fontSize: 10,height: 1.6,color: AppColors.kRed),),
                ),
                YMargin(70),


                RoundedNextButton(
                  onTap: pinViewModel.amount.isEmpty? null : double.parse(pinViewModel.amount) < 1000 ? null: (){
                    savingViewModel.amountToSave = double.parse(pinViewModel.amount);
                    Navigator.push(context, ChooseFundingScreen.route());
                    pinViewModel.resetAmount();
                  },
                ),
                YMargin(65),
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