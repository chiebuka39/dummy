import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/account/forgot_password_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(),
        settings:
        RouteSettings(name: LoginScreen().toStringShort()));
  }
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        title: Text("Log In",
          style: TextStyle(color: Colors.black87,fontSize: 14),),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Email Address", style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15)),
            YMargin(19),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightText,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "First Name",
                    hintStyle: TextStyle(
                        fontSize: 14
                    )
                ),
              ),
            ),
            YMargin(30),
            Text("Password", style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15),),
            YMargin(19),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightText,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Last Name",
                    hintStyle: TextStyle(
                        fontSize: 14,

                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(ForgotPasswordScreen.route());
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("Forgot Password?", style: TextStyle(fontSize: 12),),
                ),
              )
            ],),
            Spacer(),
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimaryColor
                ),
                child: Center(child: Icon(Icons.navigate_next,color: Colors.white,),),
              ),
            ),
            YMargin(50),
            Center(
              child: FlatButton(onPressed: (){}, child: Text("Don't have an account? Create account",
                style: TextStyle(fontSize: 12),)),
            ),
            YMargin(60),
          ],),
      ),
    );
  }
}
