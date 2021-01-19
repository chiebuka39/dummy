import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/savings_view_model.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/automate_screen.dart';
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

class _SaveFrequencyScreenState extends State<SaveFrequencyScreen> with
    AfterLayoutMixin<SaveFrequencyScreen> {

  ABSSavingViewModel savingViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) async{

  }

  int frequency = 0;
  @override
  Widget build(BuildContext context) {

    identityViewModel = Provider.of(context);
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
          YMargin(42),
          Text("How often would you like to save?",
            style: TextStyle(fontSize: 15,
                fontFamily: AppStrings.fontBold),),
          YMargin(35),
            ...List.generate( 3, (index) {
              var freq = savingViewModel.savingFrequency[index];
              return InkWell(
                onTap: (){
                  print("lll ${freq.id}");
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
              onTap: savingViewModel.selectedFrequency == null ? null: (){
                Navigator.push(context, AutomateSavingsScreen.route());
              },
            )
        ],),
      ),
    );
  }

  int buildLength() {
    print("ooooo ${savingViewModel.endDate.difference(savingViewModel.startDate).inDays}");
    if(savingViewModel.endDate.difference(savingViewModel.startDate).inDays < 180){
      return savingViewModel.savingFrequency.length -2;
    }else{
      return savingViewModel.savingFrequency.length;
    }

  }
}
