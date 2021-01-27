import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/pin_view_model.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/keyboard_widget.dart';


class UsePinWidget extends StatefulWidget {
  const UsePinWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  _UsePinWidgetState createState() => _UsePinWidgetState();
}

class _UsePinWidgetState extends State<UsePinWidget> {



  ABSIdentityViewModel identityViewModel;
  ABSPinViewModel pinViewModel;
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    pinViewModel = Provider.of(context);

    final node = FocusScope.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(10),
            Transform.translate(
              offset: Offset(-20,0),
              child: IconButton(
                icon:  Icon(Icons.navigate_before_outlined, color: AppColors.kPrimaryColor,),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
            YMargin(10),
            Text("Enter Zimvest Pin", style: TextStyle(fontFamily: AppStrings.fontMedium),),
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

            YMargin(80),

            Expanded(
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "1";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "1";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "1";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "1";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("1", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "2";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "2";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "2";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "2";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("2", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "3";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "3";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "3";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "3";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("3", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
              ],),
            ),
            Container(
              child: Expanded(
                child: Row(children: [
                  Expanded(
                    child: GestureDetector(
                      onTap:(){
                        if(pinViewModel.pin1.isEmpty){

                            pinViewModel.pin1 = "4";

                        }else if(pinViewModel.pin2.isEmpty){

                            pinViewModel.pin2 = "4";

                        }else if(pinViewModel.pin3.isEmpty){

                            pinViewModel.pin3 = "4";

                        }else if(pinViewModel.pin4.isEmpty){

                            pinViewModel.pin4 = "4";

                          confirmCode();
                        }
                      },
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text("4", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        if(pinViewModel.pin1.isEmpty){

                            pinViewModel.pin1 = "5";

                        }else if(pinViewModel.pin2.isEmpty){

                            pinViewModel.pin2 = "5";

                        }else if(pinViewModel.pin3.isEmpty){

                            pinViewModel.pin3 = "5";

                        }else if(pinViewModel.pin4.isEmpty){

                            pinViewModel.pin4 = "5";

                          confirmCode();
                        }
                      },
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text("5", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        if(pinViewModel.pin1.isEmpty){

                            pinViewModel.pin1 = "6";

                        }else if(pinViewModel.pin2.isEmpty){

                            pinViewModel.pin2 = "6";

                        }else if(pinViewModel.pin3.isEmpty){

                            pinViewModel.pin3 = "6";

                        }else if(pinViewModel.pin4.isEmpty){

                            pinViewModel.pin4 = "6";

                          confirmCode();
                        }
                      },
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Center(
                          child: Text("6", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                ],),
              ),
            ),

            Expanded(
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "7";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "7";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "7";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "7";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("7", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "8";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "8";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "8";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "8";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("8", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "9";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "9";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "9";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "9";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("9", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
              ],),
            ),
            Expanded(
              child: Row(children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text("", style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin1.isEmpty){

                          pinViewModel.pin1 = "0";

                      }else if(pinViewModel.pin2.isEmpty){

                          pinViewModel.pin2 = "0";

                      }else if(pinViewModel.pin3.isEmpty){

                          pinViewModel.pin3 = "0";

                      }else if(pinViewModel.pin4.isEmpty){

                          pinViewModel.pin4 = "0";

                        confirmCode();
                      }
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Text("0", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if(pinViewModel.pin4.isNotEmpty){
                        pinViewModel.pin4 = '';
                      }else if(pinViewModel.pin3.isNotEmpty){
                        pinViewModel.pin3 = '';
                      }else if(pinViewModel.pin2.isNotEmpty){
                        pinViewModel.pin2 = '';
                      }else if(pinViewModel.pin1.isNotEmpty){
                        pinViewModel.pin1 = '';
                      }

                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(
                        child: Icon(Icons.arrow_back_ios,size: 18,color: AppColors.kPrimaryColor,),
                      ),
                    ),
                  ),
                ),
              ],),
            )

          ],),
      ),
    );
  }

  void confirmCode() async{
    print("Lalalshisih ${pinViewModel.pin1}${pinViewModel.pin2}${pinViewModel.pin3}${pinViewModel.pin4}");
    Navigator.pop(context);
    widget.onNext();
  }
}

class UseOTPWidget extends StatefulWidget {
  const UseOTPWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  _UseOTPWidgetState createState() => _UseOTPWidgetState();
}

class _UseOTPWidgetState extends State<UseOTPWidget> {



  ABSIdentityViewModel identityViewModel;
  ABSPinViewModel pinViewModel;
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    pinViewModel = Provider.of(context);
    final node = FocusScope.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(10),
            Transform.translate(
              offset: Offset(-20,0),
              child: IconButton(
                icon:  Icon(Icons.navigate_before_outlined, color: AppColors.kPrimaryColor,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            YMargin(10),
            Text("Enter Zimvest Pin", style: TextStyle(fontFamily: AppStrings.fontMedium),),
            YMargin(50),
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

            YMargin(80),
            VerifyKeyboardWidget(
              confirmCode: confirmCode,
            )



          ],),
      ),
    );
  }

  void confirmCode() async{
    Navigator.pop(context);
    widget.onNext();
  }
}