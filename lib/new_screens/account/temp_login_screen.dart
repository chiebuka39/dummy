import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => TempLoginScreen(),
        settings:
        RouteSettings(name: TempLoginScreen().toStringShort()));
  }
  @override
  _TempLoginScreenState createState() => _TempLoginScreenState();
}

class _TempLoginScreenState extends State<TempLoginScreen> {
  bool obscureText = false;
  ABSIdentityViewModel identityViewModel;
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  bool loading = false;

  String password = "";

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
                    color: AppColors.kLightText,
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
                    IconButton(icon: Icon(Icons.visibility_off,size: 20,), onPressed: (){

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
                  }:null,
                ),
              ),
              YMargin(40),
              Center(
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
    );
  }
}


