import 'package:flutter/material.dart';
import 'package:zimvest/screens/analysis/investment_profile_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/appbars.dart';
import 'package:zimvest/widgets/buttons.dart';

class InvestmentPersonaScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => InvestmentPersonaScreen(),
        settings: RouteSettings(name: InvestmentPersonaScreen().toStringShort()));
  }
  @override
  _InvestmentPersonaScreenState createState() => _InvestmentPersonaScreenState();
}

class _InvestmentPersonaScreenState extends State<InvestmentPersonaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZimAppBar(title: "Investment Persona Analysis",),
      backgroundColor: AppColors.kLightBG,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("In developing an investment plan, it is important to identify "
                "your profile as an investor.\n\nThis is dependent on your investment "
                "objectives, your attitude to risk and the time frame required to meet "
                "your objectives. \nTo enable you and Zedcrest Investment Managers have a "
                "good understanding of your goals and risk profile, we will appreciate it "
                "if you kindly fill out the form and provide answers to the self evaluation "
                "questions provided in the pages following. You may also find that responding "
                "to all the questions can help you identify your investment objective more "
                "precisely.",
              style: TextStyle(fontSize: 12, height: 2),),
            YMargin(20),
            Text("Please be assured that details provided will be kept confidential "
                "and secure and would not be shared with any other party",
              style: TextStyle(fontSize: 12, height: 2, fontFamily: "Caros-Medium"),),
            Spacer(),
            PrimaryButton(

              title: "Take IPS test",
              onPressed: (){
                Navigator.of(context).push(InvestmentProfileScreen.route());
              },
            )
          ],
        ),
      ),
    );
  }
}
