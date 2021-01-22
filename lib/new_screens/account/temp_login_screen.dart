import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/new_screens/account/create_pin_screen.dart';
import 'package:zimvest/new_screens/account/forgot_password_screen.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
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
  List<BiometricType> _availableBiometrics;


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

      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        password = _localStorage.getSecondaryState().password;
      });
      print("<<<<<<<aaaaaaaa<<<<<");
      if(authenticated == true){
        login(context1);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;


  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if(_localStorage.getSecondaryState().biometricsEnabled == true){
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
                YMargin(40),
                Text("Good morning, ${identityViewModel.user.fullname.split(" ").first}",
                  style: TextStyle(fontSize: 17, fontFamily: AppStrings.fontBold),),
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
                        obscureText == true ? Icons.visibility_off:Icons.visibility,size: 20,color: AppColors.kPrimaryColor,), onPressed: (){
                          setState(() {
                            obscureText = !obscureText;
                          });

                      })
                    ],
                  ),
                ),
                YMargin(40),
                YMargin(40),
                Center(
                  child: GestureDetector(
                    onTap:_localStorage.getSecondaryState().biometricsEnabled == true ? (){
                      _authenticate(context);
                    }:null,
                    child: SvgPicture.asset("images/new/face_id.svg",),
                  ),
                ),
                YMargin(40),
                Center(
                  child: FlatButton(onPressed: (){
                    Navigator.push(context, ForgotPasswordScreen.route());
                  }, child: Text("Forgot your password", style: TextStyle(
                      fontSize: 12,
                      color: AppColors.kGreyText
                  ),)),
                ),
                Center(
                  child: FlatButton(onPressed: (){
                    Navigator.push(context, LoginScreen.route());
                  }, child: Text("Not You, Switch account", style: TextStyle(
                      fontSize: 12,
                      color: AppColors.kGreyText
                  ),)),
                ),
                YMargin(MediaQuery.of(context).size.height * 0.15),
                RoundedNextButton(
                  loading: loading,
                  onTap: password.length  >=8  ? ()async{

                    await login(context);
                  }:null,
                )
              ],
            ),
          ),
        ),
    );
  }

  Future login(BuildContext context) async {
    EasyLoading.show(status: "");
    var result = await identityViewModel.login(_localStorage.getSecondaryState().email, password);
    EasyLoading.dismiss();
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


