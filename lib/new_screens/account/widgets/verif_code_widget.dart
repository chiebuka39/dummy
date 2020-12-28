import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/new_screens/account/login_screen.dart';
import 'package:zimvest/new_screens/account/widgets/change_mail_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';


class VerifCodeWidget extends StatefulWidget {
  const VerifCodeWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final Function onNext;

  @override
  _VerifCodeWidgetState createState() => _VerifCodeWidgetState();
}

class _VerifCodeWidgetState extends State<VerifCodeWidget> with AfterLayoutMixin<VerifCodeWidget>{

  String pin1 = "";
  String pin2 = "";
  String pin3 = "";
  String pin4 = "";
  String pin5 = "";
  String pin6 = "";

  bool verificationCodeLoading = false;

  ABSIdentityViewModel identityViewModel;

  @override
  void afterFirstLayout(BuildContext context) async{

  }

  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    final node = FocusScope.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(50),
          Text("Enter Verification Code", style: TextStyle(fontFamily: AppStrings.fontMedium),),
          YMargin(12),
          SizedBox(
            width: 225,
            child: Text("Please enter the code that was sent to jondave@aza.com", style: TextStyle(
                fontSize: 11,color: Colors.black54, fontFamily: AppStrings.fontNormal
            ),),
          ),
          YMargin(30),
          Row(children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,

                decoration: pin1.isEmpty ?  BoxDecoration(
                    color: Color(0xFFF9F2DD),
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(7)
                ): BoxDecoration(
                    color: Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(pin1,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
            XMargin(11),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
               
                decoration: (pin1.isNotEmpty && pin2.isEmpty) ? BoxDecoration(
                    color: Color(0xFFF9F2DD),
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(7)
                ):BoxDecoration(
                    color: Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(pin2,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),

            XMargin(11),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
                decoration:(pin1.isNotEmpty && pin2.isNotEmpty && pin3.isEmpty) ? BoxDecoration(
                    color: Color(0xFFF9F2DD),
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(7)
                ): BoxDecoration(
                    color: Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(pin3,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
            XMargin(11),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
               
                decoration:(pin1.isNotEmpty && pin2.isNotEmpty && pin3.isNotEmpty && pin4.isEmpty) ? BoxDecoration(
                    color: Color(0xFFF9F2DD),
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(7)
                ):  BoxDecoration(
                    color: Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(pin4,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
            XMargin(11),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,

                decoration:(pin1.isNotEmpty && pin2.isNotEmpty && pin3.isNotEmpty && pin4.isNotEmpty && pin5.isEmpty) ? BoxDecoration(
                    color: Color(0xFFF9F2DD),
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(7)
                ):  BoxDecoration(
                    color: Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(pin5,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
            XMargin(11),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,

                decoration:(pin1.isNotEmpty && pin2.isNotEmpty && pin3.isNotEmpty && pin4.isNotEmpty && pin5.isNotEmpty && pin6.isEmpty) ? BoxDecoration(
                    color: Color(0xFFF9F2DD),
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: BorderRadius.circular(7)
                ):  BoxDecoration(
                    color: Color(0xFFE7E7E7),
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text(pin6,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
          ],),
          YMargin(10),
          Center(child: FlatButton(onPressed: verificationCodeLoading ? null: ()async{
            var result = await identityViewModel.resendEmailOTP(
              verificationId: identityViewModel.verificationId,
              trackingId: identityViewModel.trackingId
            );
          }, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Resend Verification Code"),
              verificationCodeLoading? Padding(
                padding: const EdgeInsets.only(left: 3),
                child: CupertinoActivityIndicator(),
              ):SizedBox()
            ],
          ))),
          Center(child: FlatButton(onPressed: (){
            Navigator.push(context, ChangeMailWidget.route());
          }, child: Text("Change Email Address"))),
          YMargin(40),


          Expanded(
            child: Row(children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    if(pin1.isEmpty){
                      setState(() {
                        pin1 = "1";
                      });
                    }else if(pin2.isEmpty){
                      setState(() {
                        pin2 = "1";
                      });
                    }else if(pin3.isEmpty){
                      setState(() {
                        pin3 = "1";
                      });
                    }else if(pin4.isEmpty){
                      setState(() {
                        pin4 = "1";
                      });
                    }else if(pin5.isEmpty){
                      setState(() {
                        pin5 = "1";
                      });
                    }
                    else if(pin6.isEmpty){
                      setState(() {
                        pin6 = "1";
                      });
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
                child: InkWell(
                  onTap: (){
                      if(pin1.isEmpty){
                        setState(() {
                          pin1 = "2";
                        });
                      }else if(pin2.isEmpty){
                        setState(() {
                          pin2 = "2";
                        });
                      }else if(pin3.isEmpty){
                        setState(() {
                          pin3 = "2";
                        });
                      }else if(pin4.isEmpty){
                        setState(() {
                          pin4 = "1";
                        });
                      }
                      else if(pin5.isEmpty){
                        setState(() {
                          pin5 = "2";
                        });

                      }else if(pin6.isEmpty){
                        setState(() {
                          pin6 = "2";
                        });
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
                child: InkWell(
                  onTap: (){
                    if(pin1.isEmpty){
                      setState(() {
                        pin1 = "3";
                      });
                    }else if(pin2.isEmpty){
                      setState(() {
                        pin2 = "3";
                      });
                    }else if(pin3.isEmpty){
                      setState(() {
                        pin3 = "3";
                      });
                    }else if(pin4.isEmpty){
                      setState(() {
                        pin4 = "3";
                      });
                    }else if(pin5.isEmpty){
                      setState(() {
                        pin5 = "3";
                      });

                    }
                    else if(pin6.isEmpty){
                      setState(() {
                        pin6 = "3";
                      });
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
                  child: InkWell(
                    onTap:(){
                      if(pin1.isEmpty){
                        setState(() {
                          pin1 = "4";
                        });
                      }else if(pin2.isEmpty){
                        setState(() {
                          pin2 = "4";
                        });
                      }else if(pin3.isEmpty){
                        setState(() {
                          pin3 = "4";
                        });
                      }else if(pin4.isEmpty){
                        setState(() {
                          pin4 = "4";
                        });
                      }
                      else if(pin5.isEmpty){
                        setState(() {
                          pin5 = "4";
                        });

                      }else if(pin6.isEmpty){
                        setState(() {
                          pin6 = "4";
                        });
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
                  child: InkWell(
                    onTap: (){
                      if(pin1.isEmpty){
                        setState(() {
                          pin1 = "5";
                        });
                      }else if(pin2.isEmpty){
                        setState(() {
                          pin2 = "5";
                        });
                      }else if(pin3.isEmpty){
                        setState(() {
                          pin3 = "5";
                        });
                      }else if(pin4.isEmpty){
                        setState(() {
                          pin4 = "5";
                        });
                      }
                      else if(pin5.isEmpty){
                        setState(() {
                          pin5 = "5";
                        });
                      }else if(pin6.isEmpty){
                        setState(() {
                          pin6 = "5";
                        });
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
                  child: InkWell(
                    onTap: (){
                      if(pin1.isEmpty){
                        setState(() {
                          pin1 = "6";
                        });
                      }else if(pin2.isEmpty){
                        setState(() {
                          pin2 = "6";
                        });
                      }else if(pin3.isEmpty){
                        setState(() {
                          pin3 = "6";
                        });
                      }else if(pin4.isEmpty){
                        setState(() {
                          pin4 = "6";
                        });
                      }else if(pin5.isEmpty){
                        setState(() {
                          pin5 = "6";
                        });
                      }else if(pin6.isEmpty){
                        setState(() {
                          pin6 = "6";
                        });
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
                child: InkWell(
                  onTap: (){
                    if(pin1.isEmpty){
                      setState(() {
                        pin1 = "7";
                      });
                    }else if(pin2.isEmpty){
                      setState(() {
                        pin2 = "7";
                      });
                    }else if(pin3.isEmpty){
                      setState(() {
                        pin3 = "7";
                      });
                    }else if(pin4.isEmpty){
                      setState(() {
                        pin4 = "7";
                      });
                    }
                    else if(pin5.isEmpty){
                      setState(() {
                        pin5 = "7";
                      });

                    }else if(pin6.isEmpty){
                      setState(() {
                        pin6 = "7";
                      });
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
                child: InkWell(
                  onTap: (){
                    if(pin1.isEmpty){
                      setState(() {
                        pin1 = "8";
                      });
                    }else if(pin2.isEmpty){
                      setState(() {
                        pin2 = "8";
                      });
                    }else if(pin3.isEmpty){
                      setState(() {
                        pin3 = "8";
                      });
                    }else if(pin4.isEmpty){
                      setState(() {
                        pin4 = "8";
                      });
                    }
                    else if(pin5.isEmpty){
                      setState(() {
                        pin5 = "8";
                      });

                    }
                    else if(pin6.isEmpty){
                      setState(() {
                        pin6 = "8";
                      });
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
                child: InkWell(
                  onTap: (){
                    if(pin1.isEmpty){
                      setState(() {
                        pin1 = "9";
                      });
                    }else if(pin2.isEmpty){
                      setState(() {
                        pin2 = "9";
                      });
                    }else if(pin3.isEmpty){
                      setState(() {
                        pin3 = "9";
                      });
                    }else if(pin4.isEmpty){
                      setState(() {
                        pin4 = "9";
                      });
                    }else if(pin5.isEmpty){
                      setState(() {
                        pin5 = "9";
                      });
                    }else if(pin6.isEmpty){
                      setState(() {
                        pin6 = "9";
                      });
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
                    color: Colors.transparent,
                  child: Center(
                    child: Text("", style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    if(pin1.isEmpty){
                      setState(() {
                        pin1 = "0";
                      });
                    }else if(pin2.isEmpty){
                      setState(() {
                        pin2 = "0";
                      });
                    }else if(pin3.isEmpty){
                      setState(() {
                        pin3 = "0";
                      });
                    }else if(pin4.isEmpty){
                      setState(() {
                        pin4 = "0";
                      });
                    }else if(pin5.isEmpty){
                      setState(() {
                        pin5 = "0";
                      });
                    }else if(pin6.isEmpty){
                      setState(() {
                        pin6 = "0";
                      });
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
                child: InkWell(
                  onTap: (){
                    if(pin6.isNotEmpty){
                      pin6 = '';
                    } else if(pin5.isNotEmpty){
                      pin5 = '';
                    }else if(pin4.isNotEmpty){
                      pin4 = '';
                    }else if(pin3.isNotEmpty){
                      pin3 = '';
                    }else if(pin2.isNotEmpty){
                      pin2 = '';
                    }else if(pin1.isNotEmpty){
                      pin1 = '';
                    }
                    setState(() {

                    });
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
    );
  }

  void confirmCode() async{

    EasyLoading.show(status: 'Creating account');
    var result = await identityViewModel.confirmEmailOTP(code: "$pin1$pin2$pin3$pin4$pin5${pin6}");

    if(result.error == true) {
      EasyLoading.showError('Error occurred');
    }else{

      var result = await identityViewModel.registerIndividual(
        password: identityViewModel.password,
        phoneNumber: identityViewModel.phoneNumber,
        firstName: identityViewModel.firstName,
        lastName: identityViewModel.lastName,
        email: identityViewModel.email,
        dob: "${identityViewModel.dob.year}-${AppUtils.addPreceedingZero(identityViewModel.dob.month.toString())}-${AppUtils.addPreceedingZero(identityViewModel.dob.day.toString())}"
      );
      if(result.error == false){
        await  Future.delayed(Duration(seconds: 5));
        var result = await identityViewModel.login(
          identityViewModel.email, identityViewModel.password,
        );
        if(result.error == false){
          EasyLoading.showSuccess("Mail Confirmed");
          Future.delayed(Duration(milliseconds: 700)).then((value) =>
              widget.onNext());
        }else{
          EasyLoading.showError('You could not be logged in');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
        }
      }else{
        EasyLoading.showError('Account could not be created');
        setState(() {
          pin1 = "";
          pin2 = "";
          pin3 = "";
          pin4 = "";
          pin5 = "";
          pin6 = "";
        });
      }

    }
  }
}