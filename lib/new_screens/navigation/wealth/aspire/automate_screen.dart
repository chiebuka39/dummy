import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/choose_funding_source.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
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
        appBar: ZimAppBar(callback: (){
          Navigator.pop(context);
        },icon: Icons.arrow_back_ios_outlined,text: "Create Zimvest Aspire",),
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
