import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ChangePasswordScreen(),
        settings:
        RouteSettings(name: ChangePasswordScreen().toStringShort()));
  }
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  String oldPassword = "";
  String newPassword = "";

  bool obscureTextOld = true;
  bool obscureText = true;
  bool loading = false;

  ABSIdentityViewModel identityViewModel;

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        text: "Change Password",
        callback: (){
          Navigator.pop(context);
        },
        icon: Icons.close,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(30),
          Text("Old Password", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
          YMargin(20),
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
                          oldPassword = value;
                        });
                      },
                      obscureText: obscureTextOld,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "",
                          hintStyle: TextStyle(
                              fontSize: 14
                          )
                      ),
                    ),
                  ),
                ),
                IconButton(icon: Icon( obscureTextOld ? Icons.visibility_off:Icons.visibility,size: 20,color: AppColors.kPrimaryColor,), onPressed: (){
                  setState(() {
                    obscureTextOld = !obscureTextOld;
                  });
                })
              ],
            ),
          ),
          YMargin(40),
            Text("New Password", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
            YMargin(20),
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
                          newPassword = value;
                        });
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "",
                          hintStyle: TextStyle(
                              fontSize: 14
                          )
                      ),
                    ),
                  ),
                ),
                IconButton(icon: Icon( obscureText ? Icons.visibility_off:Icons.visibility,size: 20,color: AppColors.kPrimaryColor,), onPressed: (){
                  setState(() {
                    obscureText = !obscureText;
                  });
                })
              ],
            ),
          ),
          YMargin(10),
          Row(children: [
            newPassword.length >= 8 ?PasswordCheck(title: '8+ characters',)
                :PasswordError(title: '8+ characters',),
            XMargin(5),
            hasSpecial(newPassword) ? PasswordCheck(title: '1 Special Character',flex: 3,)
                :PasswordError(title: '1 Special Character',flex: 3,),
            XMargin(5),
            hasNum(newPassword) ?PasswordCheck(title: '1+ Number',)
                : PasswordError(title: '1+ Number',),


          ],),
            Spacer(),
            Center(
              child: PrimaryButtonNew(
                loading: loading,
                title: "Change Password",
                onTap:(isValidPass(newPassword) && oldPassword.length > 8) ?  ()async{
                  setState(() {
                    loading = true;
                  });
                  var result = await identityViewModel.changePassword(
                      newPassword: newPassword,
                      currentPassword: oldPassword
                  );
                  setState(() {
                    loading = false;
                  });
                  if(result.error == false){
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return PasswordSuccessWidget(onDone: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },);
                    });
                  }else{
                    print("error occured");
                    showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                      return PasswordSuccessWidget(
                        message: result.errorMessage,
                        onDone: (){
                          Navigator.pop(context);
                        },
                      );
                    });
                  }

                }:null,
              ),
            ),
            Spacer(),

        ],),
      ),
    );
  }

  String specialChar =
      r'^(?=.*?[)(\][)(|:};{?.="\u0027%!+<@>#\$/&*~^_-`,\u005C\u002D])';

  String oneNumber = r'^(?=.*?[0-9])';
  final caps1 = RegExp(r'^[a-zA-Z0-9]+$');
  final caps = RegExp(r'^(?=.*?[A-Z])',unicode: true);
  bool isValidPass(String password) {



    //print("regex $hasCaps $hasLower $hasSpecial ${password.length >= 8}");
    return  hasSpecial(password) == true && hasNum(password) == true && password.length >= 8;
  }

  bool hasNum(String password){
    return RegExp(oneNumber,unicode: true).hasMatch(password);
  }

  bool hasSpecial(String password){
    return RegExp(specialChar,unicode: true).hasMatch(password);
  }
}
