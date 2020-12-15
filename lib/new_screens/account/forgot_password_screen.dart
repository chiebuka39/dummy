import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => ForgotPasswordScreen(),
        settings: RouteSettings(name: ForgotPasswordScreen().toStringShort()));
  }

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = "";

  bool _emailError = false;
  bool loading = false;

  bool autoValidate = false;
  ABSIdentityViewModel _identityViewModel;

  var forgotPasswordDone = false;

  @override
  Widget build(BuildContext context) {
    _identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Forgot password",
          style: TextStyle(color: Colors.black87, fontSize: 14 ,fontFamily: AppStrings.fontMedium),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            forgotPasswordDone
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        YMargin(50),
                        Text("Please Check Your Email Address",
                            style: TextStyle(
                                fontFamily: AppStrings.fontBold, fontSize: 15)),
                        YMargin(19),
                        Text(
                          "We just sent you an email with a link to reset your password,"
                          "please click on the link to reset your password.",
                          style: TextStyle(
                              fontSize: 11, color: AppColors.kLightText3),
                        ),
                      ],
                    ),
                  )
                : buildEnterEmail(),
            Spacer(),
            Center(
              child: PrimaryButtonNew(
                  title: "Reset My Password",
                  loading: loading,
                  onTap: forgotPasswordDone
                      ? () {
                          Navigator.of(context).push(LoginScreen.route());
                        }
                      : () async {
                          setState(() {
                            autoValidate = true;
                          });
                          if (_emailError || _email.isEmpty) {
                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          var result =
                              await _identityViewModel.resetPassword(_email);
                          setState(() {
                            loading = false;
                          });
                          if (result.error == true) {
                            AppUtils.showError(context,
                                title: 'Error Occured',
                                message:
                                    "We could not send a reset eamil, please send another one");
                            print("login failed");
                          } else {
                            setState(() {
                              forgotPasswordDone = true;
                            });

                            print("success");
                            //Navigator.of(context).pushReplacement(TabsContainer.route());
                          }
                          //
                        }),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Container buildEnterEmail() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(50),
          Text("Enter Email Address",
              style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15)),
          YMargin(19),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.kGreyBg,
                borderRadius: BorderRadius.circular(12)),
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
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          if (autoValidate == false ? false : _emailError)
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Text(
                "Email is incorrect",
                style: TextStyle(fontSize: 11, color: AppColors.kRed),
              ),
            )
          else
            SizedBox(),
        ],
      ),
    );
  }
}
