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

class SecuritySwitchWidget extends StatelessWidget {

  final bool status;
  final String title;

  final Function toggle;

  const SecuritySwitchWidget({Key key, this.status,
    this.toggle, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        toggle(!status);
      },
      child: Container(height: 60,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 13,
                fontFamily: AppStrings.fontNormal),),
            Spacer(),
            FlutterSwitch(
              width: 50.0,
              height: 30.0,
              toggleSize: 20.0,
              value: status,
              borderRadius: 30.0,
              padding: 2.0,
              activeToggleColor: AppColors.kWhite,
              inactiveToggleColor: AppColors.kWhite,
              activeSwitchBorder: Border.all(
                color: Color(0xFF3C1E70),
                width: 0.0,
              ),
              inactiveSwitchBorder: Border.all(
                color: Color(0xFFD1D5DA),
                width: 0.0,
              ),
              activeColor: AppColors.kPrimaryColor,
              inactiveColor: AppColors.kGrey,
              activeIcon: Icon(
                Icons.check,
                color: AppColors.kPrimaryColor,
                size: 15,
              ),
              inactiveIcon: Icon(
                Icons.wb_sunny,
                color: Colors.transparent,
              ),
              onToggle: (val) {
                toggle(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}

