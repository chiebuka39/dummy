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
import 'package:zimvest/widgets/new/new_widgets.dart';

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
      appBar: ZimAppBar(
        icon: Icons.arrow_back_ios_outlined,
        text: 'Create Zimvest WealthBox',
        callback: (){
          Navigator.pop(context);
        },
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
            ...List.generate(3, (index) {
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
