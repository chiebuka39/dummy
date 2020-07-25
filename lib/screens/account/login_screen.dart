import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/screens/account/creat_account_screen.dart';
import 'package:zimvest/screens/menu_container.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => LoginScreen(),
        settings: RouteSettings(name: LoginScreen().toStringShort()));
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ABSIdentityViewModel _identityViewModel;
  bool obscureText2 = true;
  bool autoValidate = false;
  String _email;
  String _password;

  bool _emailError = true;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YMargin(11),
                  Text(
                    "Login to your account",
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 20,
                        fontFamily: "Caros-Bold"),
                  ),
                  YMargin(11),
                  Text(
                    "Enter your login information to access zimvest",
                    style: TextStyle(
                        color: AppColors.kLightText3,
                        fontSize: 12,
                        fontFamily: "Caros-Medium"),
                  ),
                  YMargin(120),
                  EmailWidget(
                    title: "Email or Phone number",
                    onChange: (value) {
                      print("oooo $value");
                      if (EmailValidator.validate(value)) {
                        _emailError = false;
                      } else {
                        _emailError = true;
                      }
                      _email = value;
                      setState(() {});
                    },
                    error: autoValidate == false ? false : _emailError,
                  ),
                  LoginPasswordWidget(
                    title: "Password",
                    error:  autoValidate == false ? false : _password == null,
                    onChange: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  YMargin(40),
                  PrimaryButton(
                    title: "Log in",
                    loading: _loading,
                    onPressed: () async{
                      setState(() {
                        autoValidate = true;
                      });
                      if(_emailError || _password == null){
                        return;
                      }
                      setState(() {
                        _loading = true;
                      });
                     var result = await _identityViewModel.login(_email, _password);
                      setState(() {
                        _loading = false;
                      });
                     if(result.error == true){
                        print("login failed");
                      }else{
                        Navigator.of(context).pushReplacement(MenuContainer.route());
                      }
                      //
                    },
                  ),
                  YMargin(24),
                  FlatButton(
                    onPressed: () {},
                    child: Center(
                        child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: AppColors.kAccentColor,
                          fontSize: 14,
                          fontFamily: "Caros-Bold"),
                    )),
                  ),
                  YMargin(46),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(CreateAccountScreen.route());
                    },
                    child: Center(
                        child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(fontFamily: "Caros-Medium")),
                        TextSpan(
                            text: " Create one",
                            style: TextStyle(
                                fontFamily: "Caros-Bold",
                                color: AppColors.kAccentColor))
                      ]),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
