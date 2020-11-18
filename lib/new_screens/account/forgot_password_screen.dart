import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ForgotPasswordScreen(),
        settings:
        RouteSettings(name: ForgotPasswordScreen().toStringShort()));
  }
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  bool forgotPasswordDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.clear,size: 20,),
          onPressed: (){},
        ),
        backgroundColor: Colors.transparent,
        title: Text("Forgot password",
          style: TextStyle(color: Colors.black87,fontSize: 14),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            forgotPasswordDone ?  Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(50),
                  Text("Please Check Your Email Address", style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15)),
                  YMargin(19),
                  Text("We just sent you an email with a link to reset your password,"
                    "please click on the link to reset your password.", style: TextStyle(fontSize: 11, color: AppColors.kLightText3),),
                ],),
            ):buildEnterEmail(),

            Spacer(),
            Center(
              child: GestureDetector(
                onTap: (){
                  //Navigator.of(context).push(CreateAccountScreen.route());
                },
                child: Container(
                  height: 55,
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text( forgotPasswordDone ? "Done": "Reset My Password",
                    style: TextStyle(color: Colors.white,fontSize: 13),),),
                ),
              ),
            ),
            Spacer()

          ],),
      ),
    );
  }

  Container buildEnterEmail() {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YMargin(50),
                Text("Enter Email Address", style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15)),
                YMargin(19),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kLightText,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Transform.translate(
                    offset: Offset(0,3),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Email Address",
                          hintStyle: TextStyle(
                              fontSize: 14
                          )
                      ),
                    ),
                  ),
                ),
            ],),
          );
  }
}
