import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class VerificationNeededScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => VerificationNeededScreen(),
        settings: RouteSettings(name: VerificationNeededScreen().toStringShort()));
  }
  @override
  _VerificationNeededScreenState createState() => _VerificationNeededScreenState();
}

class _VerificationNeededScreenState extends State<VerificationNeededScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.kPrimaryColor,),onPressed: (){
            Navigator.pop(context);
        },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Text("You need to complete your verification before you  can continue",
          style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
          YMargin(60),
          Container(
            height: 50,
            child: Row(
              children: [
                Text("BVN Verification",style: TextStyle(fontSize: 13,fontFamily: AppStrings.fontNormal)),
                Spacer(),
                Icon(Icons.navigate_next_rounded,color: AppColors.kPrimaryColor,)
              ],
            ),
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Text("Identity Verification",style: TextStyle(fontSize: 13,fontFamily: AppStrings.fontNormal),),
                Spacer(),
                Icon(Icons.navigate_next_rounded,color: AppColors.kPrimaryColor,)
              ],
            ),
          )
        ],),
      ),
    );
  }
}
