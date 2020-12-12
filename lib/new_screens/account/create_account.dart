import 'package:flutter/material.dart';
import 'package:zimvest/new_screens/account/widgets/choose_gender_widget.dart';
import 'package:zimvest/new_screens/account/widgets/create_pin_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_dob_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_name_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_number_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_password_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';

import 'widgets/enter_mail_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreateAccountScreen(),
        settings:
        RouteSettings(name: CreateAccountScreen().toStringShort()));
  }
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.clear,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("Create Account",
          style: TextStyle(color: Colors.black87,fontSize: 14),),
      ),
      body: PageView(
        children: [
          CreatePinWidget(),
          EnterMailWidget(),
          EnterPasswordWidget(),
          EnterDOBWidget(),
          EnterNameWidget(),
          ChooseGenderWidget(),
          EnterPhoneWidget()
        ],
      ),
    );
  }
}


