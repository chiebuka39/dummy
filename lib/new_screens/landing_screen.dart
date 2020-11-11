import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/account/create_account.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';

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
          Container(
            height: 55,
            width: 200,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Center(child: Text("Create Account",
              style: TextStyle(color: Colors.white,fontSize: 13),),),
          ),
          YMargin(45),
          FlatButton(onPressed: (){
            Navigator.of(context).push(CreateAccountScreen.route());
          }, child: Text("Log In",style: TextStyle(fontFamily: "Caros-Medium"),)),
          Spacer(),
        ],),
      ),
    );
  }
}
