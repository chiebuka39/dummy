import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/account/create_pin_screen.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class TempLoginScreen extends StatefulWidget {
  final bool show;

  const TempLoginScreen({Key key, this.show = false}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => TempLoginScreen(),
        settings:
        RouteSettings(name: TempLoginScreen().toStringShort()));
  }
  @override
  _TempLoginScreenState createState() => _TempLoginScreenState();
}

class _TempLoginScreenState extends State<TempLoginScreen> with AfterLayoutMixin<TempLoginScreen> {
  bool obscureText = true;
  ABSIdentityViewModel identityViewModel;
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  bool loading = false;

  String password = "";

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate(BuildContext context1) async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        password = _localStorage.getSecondaryState().password;
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
      print("<<<<<<<aaaaaaaa<<<<<");
      if(authenticated == true){
        login(context1);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _getAvailableBiometrics().then((value) {
      if (Platform.isIOS) {
        if (_availableBiometrics.contains(BiometricType.face)) {
          print("ios face");
          if(widget.show == true){
            _authenticate(context);
          }
        } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
          if(widget.show == true){
            _authenticate(context);
          }
          print("ios finger");
        }
      }else{
        print("android devices");
        if(widget.show == true){
          _authenticate(context);
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good morning, ${identityViewModel.user.fullname.split(" ").first}"),
                YMargin(30),
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
                          offset:  Offset(0,-2),
                          child: TextField(
                            onChanged: (value){
                              setState(() {
                                password = value;
                              });
                            },
                            obscureText: obscureText,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Password",
                                hintStyle: TextStyle(
                                    fontSize: 14
                                )
                            ),
                          ),
                        ),
                      ),
                      IconButton(icon: Icon(
                        obscureText == true ? Icons.visibility_off:Icons.visibility,size: 20,), onPressed: (){
                          setState(() {
                            obscureText = !obscureText;
                          });
                          print(";;;;;; $obscureText}");
                      })
                    ],
                  ),
                ),
                YMargin(40),
                Center(
                  child: PrimaryButtonNew(
                    loading: loading,
                    title: "Login",
                    onTap:password.length  >=8  ? ()async{

                      await login(context);
                    }:null,
                  ),
                ),
                YMargin(40),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      _authenticate(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 43,
                      height: 45,
                      child: SvgPicture.asset("images/icon_face.svg",height: 20,),
                      decoration: BoxDecoration(
                          color: AppColors.kGrey,
                        borderRadius: BorderRadius.circular(14)
                      ),

                    ),
                  ),
                ),
                YMargin(40),
                Center(
                  child: FlatButton(onPressed: (){
                    Flushbar(
                      backgroundColor: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(12),
                      borderRadius:14,
                      icon: SvgPicture.asset("images/fail.svg"),
                      flushbarPosition: FlushbarPosition.TOP,
                      titleText: Text("Login Failed!",
                        style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontMedium),),
                      messageText: Text("Error! The email address or password is incorrect",
                        style: TextStyle(fontSize: 9,fontFamily: AppStrings.fontNormal),),
                      duration:  Duration(seconds: 3),
                    )..show(context);
                  }, child: Text("Forgot your password", style: TextStyle(
                      fontSize: 12,
                      color: AppColors.kGreyText
                  ),)),
                ),
                Center(
                  child: FlatButton(onPressed: (){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return EnableFaceIdWidget();
                    });
                  }, child: Text("Not You, Switch account", style: TextStyle(
                      fontSize: 12,
                      color: AppColors.kGreyText
                  ),)),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Future login(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var result = await identityViewModel.login(_localStorage.getSecondaryState().email, password);
    setState(() {
      loading = false;
    });
    if(result.error == true){
    
      AppUtils.showError(context);
      print("login failed");
    }else{
      if(identityViewModel.user.isPinSetUp == false){
        Navigator.of(context).pushReplacement(CreatePinScreen.route());
      }else{
        Navigator.of(context).pushReplacement(TabsContainer.route());
      }
    
    }
  }
}


