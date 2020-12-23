import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/save_frequency.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/save_daily_screen.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/checkBox.dart';

class BulkSaveScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => BulkSaveScreen(),
        settings:
        RouteSettings(name: BulkSaveScreen().toStringShort()));
  }
  @override
  _BulkSaveScreenState createState() => _BulkSaveScreenState();
}

class _BulkSaveScreenState extends State<BulkSaveScreen> {

  bool yes;
  @override
  Widget build(BuildContext context) {
    ABSSavingViewModel savingViewModel = Provider.of(context);
    print("pppmmmgg h ${savingViewModel.endDate.toIso8601String()}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded,size: 25,),
          onPressed: (){
            Navigator.pop(context);
          },
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
          Text("Do you have a bulk sum saved towards this target ?",
            style: TextStyle(fontSize: 15,
                fontFamily: AppStrings.fontBold),),
          YMargin(35),
          InkWell(
            onTap: (){
              setState(() {
                yes = true;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("Yes", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: yes == true ? check:checkEmpty)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                yes = false;
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text("No", style: TextStyle(fontSize: 13),),
                  Spacer(),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 600),
                      child: yes == false ?check: checkEmpty)
                ],
              ),
            ),
          ),

            YMargin(110),
            RoundedNextButton(
              onTap: yes == null ? null: (){
                Navigator.push(context, SaveFrequencyScreen.route());
              },
            )
        ],),
      ),
    );
  }
}
