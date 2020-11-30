import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimvest/new_screens/funding/choose_funding_source.dart';
import 'package:zimvest/new_screens/funding/savings_summary.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class TopUpPlanScreen extends StatefulWidget {
  const TopUpPlanScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => TopUpPlanScreen(),
        settings:
        RouteSettings(name: TopUpPlanScreen().toStringShort()));
  }

  @override
  _TopUpPlanScreenState createState() => _TopUpPlanScreenState();
}

class _TopUpPlanScreenState extends State<TopUpPlanScreen> {



  @override
  Widget build(BuildContext context) {
    
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
          title: Text("Top Up",
            style: TextStyle(color: Colors.black87,fontSize: 14),),
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
                Text("How much do you want to send to Zimvest Wealthbox", style: TextStyle(fontSize: 15,
                    color: AppColors.kGreyText,height: 1.7,
                    fontFamily: AppStrings.fontBold),),
                YMargin(12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kTextBg,
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


                RoundedNextButton(onTap: (){
                  Navigator.of(context).push(SavingsSummaryScreen.route());
                },),
                YMargin(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Wallet balance"),
                    XMargin(5),
                    Text("${AppStrings.nairaSymbol}20,000.00", style: TextStyle(fontFamily: AppStrings.fontMedium),),
                  ],
                )



              ],),
          ),
        ),
      ),
    );
  }
}

