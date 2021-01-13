import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/new_screens/account/widgets/change_mail_widget.dart';
import 'package:zimvest/new_screens/profile/new_pin_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';


class VerifCodeScreen extends StatefulWidget {
  const VerifCodeScreen({
    Key key, this.onNext,
  }) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => VerifCodeScreen(),
        settings:
        RouteSettings(name: VerifCodeScreen().toStringShort()));
  }

  final Function onNext;

  @override
  _VerifCodeScreenState createState() => _VerifCodeScreenState();
}

class _VerifCodeScreenState extends State<VerifCodeScreen> with AfterLayoutMixin<VerifCodeScreen>{
  

  bool verificationCodeLoading = false;

  ABSIdentityViewModel identityViewModel;
  ABSPinViewModel pinViewModel;

  @override
  void afterFirstLayout(BuildContext context) async{
      var result = await identityViewModel.initiatePinReset();
  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
     pinViewModel = Provider.of(context);
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        callback: (){
          Navigator.pop(context);
        },
        text: "Reset Pin",
        icon: Icons.close,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Enter OTP", style: TextStyle(fontFamily: AppStrings.fontMedium),),
            YMargin(12),
            SizedBox(
              width: 225,
              child: Text("Please enter the code that was sent to ${identityViewModel.email}", style: TextStyle(
                  fontSize: 11,color: Colors.black54, fontFamily: AppStrings.fontNormal
              ),),
            ),
            YMargin(30),
            Row(children: [
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,

                  decoration: pinViewModel.pin1.isEmpty ?  BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ): BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin1,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              XMargin(11),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,

                  decoration: (pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ):BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin2,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),

              XMargin(11),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  decoration:(pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isNotEmpty && pinViewModel.pin3.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ): BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin3,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              XMargin(11),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,

                  decoration:(pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isNotEmpty && pinViewModel.pin3.isNotEmpty && pinViewModel.pin4.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ):  BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin4,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              XMargin(11),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,

                  decoration:(pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isNotEmpty && pinViewModel.pin3.isNotEmpty && pinViewModel.pin4.isNotEmpty && pinViewModel.pin5.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ):  BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin5,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              XMargin(11),
              Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,

                  decoration:(pinViewModel.pin1.isNotEmpty && pinViewModel.pin2.isNotEmpty && pinViewModel.pin3.isNotEmpty && pinViewModel.pin4.isNotEmpty && pinViewModel.pin5.isNotEmpty && pinViewModel.pin6.isEmpty) ? BoxDecoration(
                      color: Color(0xFFF9F2DD),
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(7)
                  ):  BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(pinViewModel.pin6,style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
            ],),
            YMargin(10),
            Center(child: FlatButton(onPressed: verificationCodeLoading ? null: ()async{
              var result = await identityViewModel.resendPinResetCode();
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Resend OTP"),
                verificationCodeLoading? Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: CupertinoActivityIndicator(),
                ):SizedBox()
              ],
            ))),
            YMargin(40),


           VerifyKeyboardWidget(
             confirmCode: confirmCode,
           )

          ],),
      ),
    );
  }

  void confirmCode() async{

    EasyLoading.show(status: 'Resetting pin');
    identityViewModel.loading = true;
    var result = await identityViewModel.verifyPinResetCode(code: "${pinViewModel.pin1}${pinViewModel.pin2}${pinViewModel.pin3}${pinViewModel.pin4}${pinViewModel.pin5}${pinViewModel.pin6}");

    if(result.error == true) {
      identityViewModel.loading = false;
      EasyLoading.showError('Error occurred');
    }else{
      EasyLoading.showSuccess("OTP Confirmed");
      pinViewModel.resetPins();
      Future.delayed(Duration(milliseconds: 700)).then((value) =>
          Navigator.pushReplacement(context, NewPinScreen.route(reset: true)));

    }
  }
}