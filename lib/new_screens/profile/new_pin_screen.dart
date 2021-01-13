import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';


class NewPinScreen extends StatefulWidget {
  final bool reset;
  final String currentPin;
  static Route<dynamic> route({bool reset = false, String pin}) {
    return MaterialPageRoute(
        builder: (_) => NewPinScreen(reset: reset,currentPin: pin,),
        settings:
        RouteSettings(name: NewPinScreen().toStringShort()));
  }
  const NewPinScreen({
    Key key,  this.reset, this.currentPin,
  }) : super(key: key);



  @override
  _NewPinScreenState createState() => _NewPinScreenState();
}

class _NewPinScreenState extends State<NewPinScreen> {



  ABSIdentityViewModel identityViewModel;

  bool completed = false;
  bool loading = false;
  ABSPinViewModel pinViewModel;
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
     pinViewModel = Provider.of(context);
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        callback: (){
          pinViewModel.resetPins();
          Navigator.pop(context);
        },
        icon: Icons.arrow_back_ios,
        text: "Change Zimvest Pin",
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(40),
              Text("Choose New Pin", style: TextStyle(fontFamily: AppStrings.fontBold, fontSize: 15,),),
              YMargin(50),
              Row(children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
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
                XMargin(25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
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
                XMargin(25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
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
                XMargin(25),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 51,
                  width: 46,
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
              ],),

              Spacer(),

              RoundedNextButton(
                loading: loading,
                onTap:completed ?  (){
                  if(widget.reset){
                    resetPin();
                  }else{
                    changePin();
                  }

                }:null,
              ),
              Spacer(),
              KeyboardWidget(
                confirmCode: (){
                  setState(() {
                    completed = true;
                  });
                },
                flex: 4,
              )



            ],),
        ),
      ),
    );
  }

  void resetPin() async{

    setState(() {
      loading = true;
    });
    identityViewModel.loading = true;
    var result = await identityViewModel.resetCode(code: "${pinViewModel.pin1}${pinViewModel.pin2}${pinViewModel.pin3}${pinViewModel.pin4}");
    setState(() {
      loading = false;
    });
    if(result.error == true) {
      identityViewModel.loading = false;
      EasyLoading.showError('Error occurred');
    }else{

      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);

    }
  }
  void changePin() async{

    setState(() {
      loading = true;
    });
    identityViewModel.loading = true;
    var result = await identityViewModel.changePin(newPin: "${pinViewModel.pin1}"
        "${pinViewModel.pin2}${pinViewModel.pin3}${pinViewModel.pin4}",
        currentPin: widget.currentPin);
    setState(() {
      loading = false;
    });
    if(result.error == true) {
      identityViewModel.loading = false;
      AppUtils.showError(context,message: result.errorMessage,title: 'Pin could not be changed');
    }else{
      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
        return PasswordSuccessWidget(
          message: "Pin Reset was successful",
          onDone: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },isDismissible: false);


    }
  }
}


