import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/profile/next_of_kin.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class VerificationDetailsScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => VerificationDetailsScreen(),
        settings:
        RouteSettings(name: VerificationDetailsScreen().toStringShort()));
  }
  @override
  _VerificationDetailsScreenState createState() => _VerificationDetailsScreenState();
}

class _VerificationDetailsScreenState extends State<VerificationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("Verification Details", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          YMargin(20),
          ProfileWidget(
            padding: 0,
            onClick: (){
              //Navigator.push(context, NextOfKinScreen.route());
            },
            title: "BVN Verification",
          ),
          ProfileWidget(
            onClick: (){
              Navigator.push(context, VerificationDetailsScreen.route());
            },
            title: "Identity Verification",
            emergency: true,
            padding: 0,
          ),
        ],),
      ),
    );
  }
}
