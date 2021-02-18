import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/choose_funding_source.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/savings_summary.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class AutomateSavingsScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AutomateSavingsScreen(),
        settings:
        RouteSettings(name: AutomateSavingsScreen().toStringShort()));
  }
  @override
  _AutomateSavingsScreenState createState() => _AutomateSavingsScreenState();
}

class _AutomateSavingsScreenState extends State<AutomateSavingsScreen> {
  Widget check = SvgPicture.asset("images/check.svg");
  Widget checkEmpty = SvgPicture.asset("images/check_empty.svg");
  bool automatic;
  ABSSavingViewModel savingViewModel;
  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);
    return Scaffold(
        appBar: ZimAppBar(
          showCancel: true,
          callback: (){
          Navigator.pop(context);
        },icon: Icons.arrow_back_ios_outlined,text: savingViewModel.selectedPlan == null ?
        "Create Zimvest Aspire":"Edit Zimvest Aspire",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(52),
          Text("Would you like to automate your savings ?",
            style: TextStyle(fontSize: 15,
                fontFamily: AppStrings.fontBold),),
          YMargin(35),
          InkWell(
            onTap: (){
              setState(() {
                automatic = true;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("Yes debit me automatically", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: automatic == true ? check:checkEmpty)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                automatic = false;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("No, I would save whenever I want", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: automatic == false ?check: checkEmpty)
                ],
              ),
            ),
          ),
            YMargin(110),
            RoundedNextButton(
              onTap: automatic == null ? null: (){

                  savingViewModel.autoSave = automatic;
                  Navigator.push(context,
                      ChooseFundingScreen.route());


              },
            )

        ],),
      ),
    );
  }
}

class SavingsAutomationWidget extends StatefulWidget {
  const SavingsAutomationWidget({
    Key key,
  }) : super(key: key);



  @override
  _SavingsAutomationWidgetState createState() => _SavingsAutomationWidgetState();
}

class _SavingsAutomationWidgetState extends State<SavingsAutomationWidget> {
  ABSSavingViewModel savingViewModel;
  Widget check = SvgPicture.asset("images/check.svg");
  Widget checkEmpty = SvgPicture.asset("images/check_empty.svg");
  bool automatic;
  @override
  Widget build(BuildContext context) {
    savingViewModel = Provider.of(context);

    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(30),
            Text("Would you like to automate your savings ?",
              style: TextStyle(fontSize: 15,
                  fontFamily: AppStrings.fontBold),),
            YMargin(35),
            InkWell(
              onTap: (){

                savingViewModel.autoSave = true;
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Text("Yes debit me automatically", style: TextStyle(fontSize: 13),),
                    Spacer(),
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 600),
                        child: automatic == true ? check:checkEmpty)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                savingViewModel.autoSave = false;
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Text("No, I would save whenever I want", style: TextStyle(fontSize: 13),),
                    Spacer(),
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 600),
                        child: automatic == false ?check: checkEmpty)
                  ],
                ),
              ),
            ),

              ],
            ),
          ),
        ))
      ],),
    );

  }
  int buildLength() {
    print("ooooo ${savingViewModel.endDate.difference(savingViewModel.startDate).inDays}");
    if(savingViewModel.endDate.difference(savingViewModel.startDate).inDays < 185){
      print("jjjjj11 ${savingViewModel.endDate.difference(savingViewModel.startDate).inDays}");
      return savingViewModel.savingFrequency.length -2;
    }else if(savingViewModel.endDate.difference(savingViewModel.startDate).inDays < 366){
      print("jjjjj22 ${savingViewModel.endDate.difference(savingViewModel.startDate).inDays}");
      return savingViewModel.savingFrequency.length -1;
    }
    else{
      return savingViewModel.savingFrequency.length;
    }

  }
}
