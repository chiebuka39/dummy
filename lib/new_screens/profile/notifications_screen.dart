import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:zimvest/new_screens/profile/change_password_screen.dart';
import 'package:zimvest/new_screens/profile/current_pin_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class NotificationsScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NotificationsScreen(),
        settings:
        RouteSettings(name: NotificationsScreen().toStringShort()));
  }

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<NotificationsScreen> {
  var status7 = false;
  var faceId = false;
  var hide = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(
        icon: Icons.arrow_back_ios_rounded,
        text: "Notifications",
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: Column(children: [
        YMargin(20),
        SecuritySwitchWidget(
          title: "Push Notifications",
          toggle: (value){
            setState(() {
              faceId = value;
            });
          },
          status: faceId,
        ),
        SecuritySwitchWidget(
          title: "Marketing Emails",
          toggle: (value){
            setState(() {
              hide = value;
            });
          },
          status: hide,
        ),
      ],),
    );
  }
}



