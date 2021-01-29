import 'package:after_layout/after_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/individual/profile.dart' as n;
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/change_password_screen.dart';
import 'package:zimvest/new_screens/profile/current_pin_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class NotificationsScreen extends StatefulWidget {
  final n.Notification  notification;

  const NotificationsScreen({Key key, this.notification}) : super(key: key);
  static Route<dynamic> route(n.Notification notification) {
    return MaterialPageRoute(
        builder: (_) => NotificationsScreen(notification: notification,),
        settings:
        RouteSettings(name: NotificationsScreen().toStringShort()));
  }

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<NotificationsScreen> with AfterLayoutMixin<NotificationsScreen> {
  var status7 = false;
  var pushEnabled = false;
  var emailsEnabled = false;

  n.Notification notification;
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;

  @override
  void initState() {
    notification = widget.notification;
    emailsEnabled = notification.subscribeToNewsLetter;
    pushEnabled = notification.receiveEmailUpdateOnSavings;

    super.initState();
  }
  @override
  void afterFirstLayout(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
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
              pushEnabled = value;
            });
            settingsViewModel.updateNotoficationSettings(
                token: identityViewModel.user.token,
                subscribeToNewsLetter: emailsEnabled,
                receiveEmailUpdateOnInvestment: pushEnabled,
                receiveEmailUpdateOnSavings: pushEnabled
            );
          },
          status: pushEnabled,
        ),
        SecuritySwitchWidget(
          title: "Marketing Emails",
          toggle: (value){
            setState(() {
              emailsEnabled = value;
            });
            settingsViewModel.updateNotoficationSettings(
              token: identityViewModel.user.token,
              subscribeToNewsLetter: emailsEnabled,
              receiveEmailUpdateOnInvestment: pushEnabled,
              receiveEmailUpdateOnSavings: pushEnabled
            );
          },
          status: emailsEnabled,
        ),
      ],),
    );
  }
}



