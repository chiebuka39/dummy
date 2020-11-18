import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/account/create_account.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(children: [
          Spacer(flex: 4,),
          Text("Zimvest", style: TextStyle(fontSize: 30, fontFamily: "Caros-Medium"),),
          YMargin(190),
          PrimaryButtonNew(
              onTap: (){
                Navigator.of(context).push(CreateAccountScreen.route());
              },
            title: "Create Account",
          ),
          YMargin(45),
          FlatButton(onPressed: (){
            Navigator.of(context).push(LoginScreen.route());
          }, child: Text("Log In",style: TextStyle(fontFamily: "Caros-Medium"),)),
          Spacer(),
        ],),
      ),
    );
  }
}


