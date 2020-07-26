import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class CreateAccountScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreateAccountScreen(),
        settings: RouteSettings(name: CreateAccountScreen().toStringShort()));
  }

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool obscureText2 = true;
  bool autoValidate = false;
  String _email;
  String _password;
  String _firstName;
  String _lastName;
  String _phoneNumber;

  bool _emailError = true;
  bool _firstNameError = true;
  bool _lastNameError = true;
  bool _phoneNumberError = true;
  bool _passwordError = true;

  @override
  Widget build(BuildContext context) {
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
                    "Create account",
                    style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 20,
                        fontFamily: "Caros-Bold"),
                  ),
                  YMargin(11),
                  Text(
                    "Set up your zimvest digital wealth account",
                    style: TextStyle(
                        color: AppColors.kLightText3,
                        fontSize: 12,
                        fontFamily: "Caros-Medium"),
                  ),
                  YMargin(40),
                  TextWidget(title: "First name",onChange: (value){
                    if(value.length < 2){
                      _firstNameError = true;
                    }else{
                      _firstNameError = false;
                    }
                    _firstName = value;
                    setState(() {});
                  },error: autoValidate == true ? _firstNameError: false),

                  TextWidget(title: "Last name",onChange: (value){
                    if(value.length < 2){
                      _lastNameError = true;
                    }else{
                      _lastNameError = false;
                    }
                    _lastName = value;
                    setState(() {});
                  },error: autoValidate == true ? _lastNameError: false,),
                  TextWidget(title: "Email",
                    textInputType: TextInputType.emailAddress,
                    onChange: (value){
                      if(EmailValidator.validate(value) == false){
                        _emailError = true;
                      }else{
                        _emailError = false;
                      }
                      _email = value;
                      setState(() {});
                    },error: autoValidate == true ? _emailError: false
                  ),
                  TextWidget(title: "Phone Number",
                    textInputType: TextInputType.phone,
                    onChange: (value){
                      if(value.length != 11){
                        _phoneNumberError = true;
                      }else{
                        _phoneNumberError = false;
                      }
                      _phoneNumber = value;
                      setState(() {});
                    },error: autoValidate == true ? _phoneNumberError: false
                  ),
                  PasswordWidget(title: "Create Password",onChange: (password,isValidPassword){
                    _password = password;
                    _passwordError = !isValidPassword;
                    setState(() {});
                  }),
                  YMargin(20),
                  PrimaryButton(
                    title: "Create account",
                    onPressed: () {
                      setState(() {
                        autoValidate = true;
                      });
                      print("$autoValidate auto");
                    },
                  ),
                  YMargin(10),
                  Center(
                      child: Container(
                        width: 250,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                          children: [
                            TextSpan(
                              text: "By clicking “Create account”, you agree to zimest’s",
                              style: TextStyle(fontSize: 10)
                            ),
                            TextSpan(
                              text: " terms and conditions",
                              recognizer: TapGestureRecognizer()..onTap = (){
                                print("kkk");
                              },
                              style: TextStyle(fontSize: 10, color: AppColors.kAccentColor)
                            ),

                            TextSpan(
                              text: " and",
                              style: TextStyle(fontSize: 10,)
                            ),
                            TextSpan(
                                text: " privacy policy",
                                style: TextStyle(fontSize: 10, color: AppColors.kAccentColor),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                print("harry");
                              },
                            ),
                          ]
                        ),),
                      )),
                  YMargin(46),
                  FlatButton(
                    onPressed: () {},
                    child: Center(
                        child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Have an account?",
                            style: TextStyle(fontFamily: "Caros-Medium")),
                        TextSpan(
                            text: " Log in",
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

class PasswordValidity extends StatelessWidget {
  final bool isValid;
  final String value;
  const PasswordValidity({
    Key key, this.isValid = true, this.value = "8+ Characters",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      XMargin(10),
      SvgPicture.asset("images/${isValid ? 'correct':'wrong'}.svg", height: 13,),
      XMargin(3),
      Text(value, style: TextStyle(color: Colors.white, fontSize: 8),)
    ],);
  }
}


