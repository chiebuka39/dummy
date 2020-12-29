import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/new_screens/profile/new_pin_screen.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';


class CurrentPinScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CurrentPinScreen(),
        settings:
        RouteSettings(name: CurrentPinScreen().toStringShort()));
  }
  const CurrentPinScreen({
    Key key, this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  _CurrentPinScreenState createState() => _CurrentPinScreenState();
}

class _CurrentPinScreenState extends State<CurrentPinScreen> {

  

  ABSIdentityViewModel identityViewModel;
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    ABSPinViewModel pinViewModel = Provider.of(context);
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        callback: (){
          Navigator.pop(context);
        },
        icon: Icons.arrow_back_ios,
        text: "Change Zimvest Pin",
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(40),
              Text("Enter Current Pin", style: TextStyle(fontFamily: AppStrings.fontBold,fontSize: 15),),
              YMargin(50),
              Row(children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
                  decoration: pinViewModel.pin1.isEmpty ?  BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ): BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin1,style: TextStyle(fontSize: 20),),
                  ),
                ),
                XMargin(25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
                  decoration: (pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ):BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin2,style: TextStyle(fontSize: 20),),
                  ),
                ),
                XMargin(25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
                  decoration:(pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isNotEmpty && pinViewModel.pin3.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ): BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin3,style: TextStyle(fontSize: 20),),
                  ),
                ),
                XMargin(25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
                  decoration:(pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isNotEmpty && pinViewModel.pin3.isNotEmpty && pinViewModel.pin4.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ):  BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin4,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],),

              Spacer(flex: 3,),

              KeyboardWidget(
                confirmCode: (){
                  Navigator.push(context, NewPinScreen.route());
                  pinViewModel.resetPins();
                },
                flex: 4,
              )

            ],),
        ),
      ),
    );
  }

  void confirmCode() async{


  }
}