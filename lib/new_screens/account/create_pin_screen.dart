import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/new_screens/tabs.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';


class CreatePinScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreatePinScreen(),
        settings:
        RouteSettings(name: CreatePinScreen().toStringShort()));
  }
  const CreatePinScreen({
    Key key,
  }) : super(key: key);

  

  @override
  _CreatePinWidgetState createState() => _CreatePinWidgetState();
}

class _CreatePinWidgetState extends State<CreatePinScreen> {

  String pin1 = "";
  String pin2 = "";
  String pin3 = "";
  String pin4 = "";

  ABSIdentityViewModel identityViewModel;
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: AppColors.kPrimaryColor,),
        
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Create Zimvest Pin", style: TextStyle(fontFamily: AppStrings.fontMedium),),
            YMargin(12),
            SizedBox(
              width: 225,
              child: Text("This code would be used for every transaction on Zimvest", style: TextStyle(
                  fontSize: 11,color: Colors.black54, fontFamily: AppStrings.fontNormal
              ),),
            ),
            YMargin(50),
            Row(children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
                width: 46,
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
              XMargin(25),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
                width: 46,
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
              XMargin(25),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
                width: 46,
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
              XMargin(25),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 51,
                width: 46,
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
            ],),
            YMargin(60),
            RoundedNextButton(
              onTap: pin4.isNotEmpty ? confirmCode:null,
            ),
            YMargin(40),

            Expanded(
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
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

                      }
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text("1", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
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
                            pin4 = "2";
                          });

                        }
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text("2", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
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

                      }
                    },
                    child: Container(
                      height: 50,
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
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text("4", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
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
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text("5", style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
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

                        }
                      },
                      child: Container(
                        height: 50,
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
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text("7", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
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
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text("8", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
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

                      }
                    },
                    child: Container(
                      height: 50,
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

                      }
                    },
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text("0", style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                     if(pin4.isNotEmpty){
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

    EasyLoading.show(status: 'Creating account');
    var result = await identityViewModel.setUpPin(pin: "$pin1$pin2$pin3$pin4");

    if(result.error == true) {
      EasyLoading.showError('Error occurred');
    }else{
      EasyLoading.showSuccess('Pin Created');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TabsContainer()),
              (Route<dynamic> route) => false);

    }
  }
}