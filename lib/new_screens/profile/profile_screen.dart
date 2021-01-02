import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/investment_view_model.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/new_screens/profile/account_screen.dart';
import 'package:zimvest/new_screens/profile/add_bank_cards.dart';
import 'package:zimvest/new_screens/profile/security_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ProfileScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ProfileScreen(),
        settings:
        RouteSettings(name: ProfileScreen().toStringShort()));
  }
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ABSInvestmentViewModel _investmentViewModel;
  ABSIdentityViewModel _identityViewModel;
  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    // _investmentViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:AppColors.kTextColor),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(icon: Icon(Icons.close, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("Profile", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset("images/new/account.svg", width: 57,),
                XMargin(20),
                Text(_identityViewModel.user.fullname, style: TextStyle(fontFamily: AppStrings.fontMedium),)
              ],
            ),
          ),
          YMargin(29),
          ProfileWidget(emergency: true,title: "Account",onClick: (){
            Navigator.push(context, AccountScreen.route());
          },icon: 'account',),
          ProfileWidget(title: "Notifications",icon: 'notif',),
          ProfileWidget(title: "Banks & Cards",icon: 'cards',
            onClick: (){
            Navigator.push(context, AddBankAndCards.route());
            },
          ),
          ProfileWidget(title: "Security",icon: 'security',
            onClick: (){
            Navigator.push(context, SecurityScreen.route());
            },
          ),
          ProfileWidget(title: "Investment Persona Analysis",icon: 'ips',),
          ProfileWidget(title: "Earn Free Cash",icon: 'earn',),
          ProfileWidget(title: "Rate App",icon: 'rate',),
          ProfileWidget(title: "About Zimvest",icon: 'about',),
          ProfileWidget(title: "Log Out",icon: 'log-out',onClick: (){
            _showConfirmLogoutDialog(context);
          },),
        ],),
      ),
    );
  }

  void _showConfirmLogoutDialog(BuildContext context) {
    var content = new Text('Do you want to log out');
    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new CupertinoAlertDialog(
              content: content,
              actions: <Widget>[
                new CupertinoDialogAction(
                    child: const Text('Yes'),
                    isDestructiveAction: true,
                    onPressed: () {
                      _logout(context);
                    }),
                new CupertinoDialogAction(
                  child: const Text('No'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              content: content,
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      _logout(context);
                    },
                    child: new Text('Yes')),
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text('No'))
              ],
            );
          });
    }
  }

  void _logout(BuildContext context) {

    final box = Hive.box(AppStrings.state);
    box.put("user", null);
    box.put("state", SecondaryState(false));
    // _investmentViewModel.reset();
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
  }
}


