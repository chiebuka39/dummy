import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/save_daily_screen.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class SaveFrequencyScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SaveFrequencyScreen(),
        settings:
        RouteSettings(name: SaveFrequencyScreen().toStringShort()));
  }
  @override
  _SaveFrequencyScreenState createState() => _SaveFrequencyScreenState();
}

class _SaveFrequencyScreenState extends State<SaveFrequencyScreen> {
  Widget check = SvgPicture.asset("images/check.svg");
  Widget checkEmpty = SvgPicture.asset("images/check_empty.svg");
  int frequency = 0;
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
          Text("How often would you like to save?",
            style: TextStyle(fontSize: 15,
                fontFamily: AppStrings.fontBold),),
          YMargin(35),
          InkWell(
            onTap: (){
              setState(() {
                frequency = 0;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("Daily", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: frequency == 0 ? check:checkEmpty)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                frequency = 1;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("Weekly", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: frequency == 1 ?check: checkEmpty)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                frequency = 2;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("Monthly", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: frequency == 2 ?check: checkEmpty)
                ],
              ),
            ),
          ),
            YMargin(110),
            RoundedNextButton(
              onTap: (){
                Navigator.push(context, SavingDailyScreen.route());
              },
            )
        ],),
      ),
    );
  }
}
