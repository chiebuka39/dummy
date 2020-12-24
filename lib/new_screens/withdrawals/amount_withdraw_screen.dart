import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/withdrawals/choose_wealth_withdraw_source.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class AmountWithdrawScreen extends StatefulWidget {
  const AmountWithdrawScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AmountWithdrawScreen(),
        settings:
        RouteSettings(name: AmountWithdrawScreen().toStringShort()));
  }

  @override
  _SavingDailyScreenState createState() => _SavingDailyScreenState();
}

class _SavingDailyScreenState extends State<AmountWithdrawScreen> {

  String amount = "";
  ABSSavingViewModel savingViewModel;


  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text("Withdraw",
            style: TextStyle(color: Colors.black87,fontSize: 13,fontFamily: AppStrings.fontMedium),),
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
                      child: Text(convertWithComma(amount), style: TextStyle(fontSize: 15),)),
                ),
                YMargin(70),


                RoundedNextButton(
                  onTap: amount.isEmpty? null : double.parse(amount) < 1000 ? null: (){
                    savingViewModel.amountToSave = double.parse(amount);
                    Navigator.push(context, ChooseWealthWithdrawScreen.route());
                  },
                ),
                YMargin(65),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "1";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("1", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "2";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("2", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "3";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("3", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                  ],),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap:(){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "4";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("4", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "5";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("5", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "6";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("6", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                  ],),
                ),

                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "7";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("7", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "8";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("8", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(

                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "9";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("9", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                  ],),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text("", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length > 11){
                            return;
                          }
                          setState(() {
                            amount = amount + "0";
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Text("0", style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          if(amount.length < 1){
                            return;
                          }
                          setState(() {
                            amount = amount.substring(0,amount.length -1);
                          });
                        },
                        child: Container(
                          height: 50,
                          color: Colors.transparent,
                          child: Center(
                            child: Icon(Icons.arrow_back_ios,size: 18,color: AppColors.kPrimaryColor,),
                          ),
                        ),
                      ),
                    ),
                  ],),
                )



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