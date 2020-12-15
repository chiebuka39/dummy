import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/save_frequency.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

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
  bool automatic = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded,size: 25,),
          onPressed: (){},
        ),
        backgroundColor: Colors.transparent,
        title: Text("Create Zimvest WealthBox",
          style: TextStyle(color: Colors.black87,fontSize: 13,fontFamily: AppStrings.fontMedium),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(72),
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
              onTap: (){
                Navigator.push(context, SaveFrequencyScreen.route());
              },
            )

        ],),
      ),
    );
  }
}
