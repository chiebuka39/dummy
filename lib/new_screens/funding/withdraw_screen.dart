import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimvest/new_screens/funding/choose_funding_source.dart';
import 'package:zimvest/new_screens/funding/choose_wealth_withdraw_source.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class WithdrawWealthScreen extends StatefulWidget {
  const WithdrawWealthScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => WithdrawWealthScreen(),
        settings:
        RouteSettings(name: WithdrawWealthScreen().toStringShort()));
  }

  @override
  _WithdrawWealthScreenState createState() => _WithdrawWealthScreenState();
}

class _WithdrawWealthScreenState extends State<WithdrawWealthScreen> {



  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          title: Text("Withdraw",
            style: TextStyle(color: Colors.black87,fontSize: 14,fontFamily: AppStrings.fontMedium),),
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
                      color: AppColors.kLightText,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Transform.translate(
                    offset: Offset(0,3),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyPtBrInputFormatter(maxDigits: 11)
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Amount",
                          hintStyle: TextStyle(
                              fontSize: 14
                          )
                      ),
                    ),
                  ),
                ),
                YMargin(50),


                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(ChooseWealthWithdrawScreen.route());
                    },
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kPrimaryColor
                      ),
                      child: Center(child: Icon(Icons.navigate_next,color: Colors.white,),),
                    ),
                  ),
                ),
                YMargin(20),



              ],),
          ),
        ),
      ),
    );
  }
}