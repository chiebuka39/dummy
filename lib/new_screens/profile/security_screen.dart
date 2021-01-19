import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/profile/change_password_screen.dart';
import 'package:zimvest/new_screens/profile/current_pin_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class SecurityScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => SecurityScreen(),
        settings:
        RouteSettings(name: SecurityScreen().toStringShort()));
  }

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  var status7 = false;
  var faceId = false;
  var hide = false;

  @override
  void initState() {
    faceId = _localStorage.getSecondaryState().biometricsEnabled == null ? false:_localStorage.getSecondaryState().biometricsEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ZimAppBar(
        icon: Icons.arrow_back_ios_rounded,
        text: "Security",
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: Column(children: [
        YMargin(20),
        SecuritySwitchWidget(
          title: "Enable Face ID",
          toggle: (value){
            setState(() {
              faceId = value;
            });
            _localStorage.saveSecondaryState(SecondaryState
                .updateBiometrics(value, _localStorage.getSecondaryState()));
          },
          status: faceId,
        ),
        SecuritySwitchWidget(
          title: "Hide Portfolio Balance",
          toggle: (value){
            setState(() {
              hide = value;
            });
          },
          status: hide,
        ),
        ProfileWidget(title: "Change Zimvest pin",
          onClick: (){
            Navigator.push(context, CurrentPinScreen.route());
          },
        ),
        ProfileWidget(title: "Reset Zimvest Pin",onClick: (){
          showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
            return ResetPinWidget();
          });
        },),
        ProfileWidget(
          title: "Change Password",
          onClick: (){
            Navigator.push(context, ChangePasswordScreen.route());
          },
        ),
      ],),
    );
  }
}



