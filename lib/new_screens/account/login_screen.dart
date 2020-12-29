import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/new_screens/account/create_account.dart';
import 'package:zimvest/new_screens/account/create_pin_screen.dart';
import 'package:zimvest/new_screens/account/forgot_password_screen.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

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
  bool loading = false;

  ABSIdentityViewModel _identityViewModel;
  bool obscureText2 = true;
  bool autoValidate = false;
  String _email = "";
  String _password = "";
  bool _emailError = false;

  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    //Password@1
    //testex.testex@mailinator.com
    return Scaffold(
      appBar: ZimAppBar(callback: (){
        Navigator.pop(context);
      },text: "Log In",),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Transform.translate(
                  offset: Offset(0,5),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        print("oooo $value");
                        if (EmailValidator.validate(value)) {
                          _emailError = false;
                        } else {
                          _emailError = true;
                        }
                        _email = value;
                        setState(() {});
                      },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                            fontSize: 14
                        )
                    ),
                  ),
                ),
              ),
              if (autoValidate == false ? false : _emailError) Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text("Email is incorrect", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
              ) else SizedBox(),
              YMargin(30),
              Text("Password", style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15),),
              YMargin(19),
              Container(

                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(0,-2),
                        child: TextField(
                          obscureText: obscureText2,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontSize: 14,

                              )
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          obscureText2 = !obscureText2;
                        });
                      },
                        child: Icon(obscureText2 ? Icons.visibility_outlined:Icons.visibility_off_outlined,size: 17,color: AppColors.kPrimaryColor,))
                  ],
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
              YMargin(50),
              RoundedNextButton(
                loading: loading,
                  onTap: _password.length < 3 ? null: () async{
                    setState(() {
                      autoValidate = true;
                    });
                    if(_emailError || _password == null){
                      return;
                    }
                    setState(() {
                      loading = true;
                    });
                    var result = await _identityViewModel.login(_email, _password);
                    setState(() {
                      loading = false;
                    });
                    if(result.error == true){

                      AppUtils.showError(context);
                      print("login failed");
                    }else{
                      if(_identityViewModel.user.isPinSetUp == false){
                        Navigator.of(context).pushReplacement(CreatePinScreen.route());
                      }else{
                        Navigator.of(context).pushReplacement(TabsContainer.route());
                      }

                    }
                    //
                  }
              ),
              YMargin(50),
              Center(
                child: FlatButton(onPressed: (){
                  Navigator.of(context).push(CreateAccountScreen.route());
                }, child: Text("Don't have an account? Create account",
                  style: TextStyle(fontSize: 12),)),
              ),
              YMargin(60),
            ],),
        ),
      ),
    );
  }
}


