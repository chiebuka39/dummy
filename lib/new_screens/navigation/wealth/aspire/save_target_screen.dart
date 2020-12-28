import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/choose_start_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class SavingsTargetScreen extends StatefulWidget {
  const SavingsTargetScreen({
    Key key,
  }) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SavingsTargetScreen(),
        settings:
        RouteSettings(name: SavingsTargetScreen().toStringShort()));
  }

  @override
  _SavingsTargetScreenState createState() => _SavingsTargetScreenState();
}

class _SavingsTargetScreenState extends State<SavingsTargetScreen> {

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
        appBar: ZimAppBar(callback: (){
          Navigator.pop(context);
        },icon: Icons.arrow_back_ios_outlined,text: "Create Zimvest Aspire",),
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
                Text("Set a target amount for this goal ?", style: TextStyle(fontSize: 15,
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
                      child: Text(amount.convertWithComma(), style: TextStyle(fontSize: 15),)),
                ),
                YMargin(10),
                SizedBox(
                  width: 300,
                  child: Text("You can always top up your savings anytime "
                      "once you create this savings plan", style: TextStyle(
                      fontSize: 10,height: 1.6),),
                ),
                YMargin(70),


                RoundedNextButton(
                  onTap:amount.isEmpty ? null : double.parse(amount) > 1000 ? (){
                    savingViewModel.amountToSave = double.parse(amount);
                    Navigator.push(context, ChooseStartScreen.route());
                  }:null,
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
                          if(amount.length > 1){
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


}