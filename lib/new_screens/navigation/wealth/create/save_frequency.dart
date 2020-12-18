import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/create/save_daily_screen.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/navigation/checkBox.dart';

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

  int frequency = 0;

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    savingViewModel = Provider.of(context);
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
          Text("How often would you like to save?",
            style: TextStyle(fontSize: 15,
                fontFamily: AppStrings.fontBold),),
          YMargin(35),
            ...List.generate(savingViewModel.savingFrequency.length, (index) {
              var freq = savingViewModel.savingFrequency[index];
              return InkWell(
                onTap: (){

                  savingViewModel.selectedFrequency = freq;
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text(freq.name, style: TextStyle(fontSize: 13),),
                      Spacer(),
                      AnimatedSwitcher(
                          duration: Duration(milliseconds: 600),
                          child: (savingViewModel.selectedFrequency?.id ?? 99) == freq.id ? check:checkEmpty)
                    ],
                  ),
                ),
              );
            }),

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
