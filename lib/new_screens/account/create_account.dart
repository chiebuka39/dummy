import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/new_screens/account/widgets/choose_gender_widget.dart';
import 'package:zimvest/new_screens/account/widgets/create_pin_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_dob_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_name_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_number_widget.dart';
import 'package:zimvest/new_screens/account/widgets/enter_password_widget.dart';
import 'package:zimvest/new_screens/account/widgets/verif_code_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:supercharged/supercharged.dart';

import 'widgets/enter_mail_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => CreateAccountScreen(),
        settings:
        RouteSettings(name: CreateAccountScreen().toStringShort()));
  }
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with AnimationMixin {
  Animation<double> size;
  double value = 0.125;
  PageController pageController = PageController();

  //user details


  ABSIdentityViewModel identityViewModel;
  int index = 0;

  @override
  void initState() {
    controller.duration = Duration(milliseconds: 300);
    size = value.tweenTo(0.25).animatedBy(controller); // <-- connect tween and controller and apply to animation variable
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    return WillPopScope(

      onWillPop: () async{
        if(identityViewModel.loading == true){
          return false;
        } else if(index != 0){
          return goBack();
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          leading: IconButton(
            icon: Icon(Icons.navigate_before_rounded,size: 26,color: AppColors.kPrimaryColor,),
            onPressed: (){
              if(index != 0){
                goBack();
              }else{
                Navigator.pop(context);
              }

            },
          ),
          backgroundColor: Colors.transparent,
          title: Text("Create Account",
            style: TextStyle(color: Colors.black87,fontSize: 14, fontFamily: AppStrings.fontMedium),),
        ),
        body: Column(
          children: [
            YMargin(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
                  backgroundColor: AppColors.kGreyBg,
                  value: size.value,
                ),
              ),
            ),

            Expanded(
              child: Container(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    EnterMailWidget(
                      onNext: (value){
                        setState(() {
                          index = index +1;
                          identityViewModel.email = value;
                          size = 0.125.tweenTo(0.25).animatedBy(controller);
                          controller.reset();
                        });
                        controller.play();


                        pageController.animateToPage(1,
                            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                    ),
                    EnterPasswordWidget(
                      onNext: (value){
                        setState(() {
                          index = index +1;
                          identityViewModel.password = value;
                          size = 0.25.tweenTo(0.375).animatedBy(controller);
                          controller.reset();
                        });
                        controller.play();
                        pageController.animateToPage(2,
                            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                    ),
                    EnterNameWidget(
                      onNext: (first,last){
                        setState(() {
                          index = index +1;
                          identityViewModel.firstName = first;
                          identityViewModel.lastName = last;
                          size = 0.375.tweenTo(0.5).animatedBy(controller);
                          controller.reset();
                        });
                        controller.play();
                        pageController.animateToPage(3,
                            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                    ),
                    EnterPhoneWidget(
                      onNext: (value){
                      setState(() {
                        index = index +1;
                        identityViewModel.phoneNumber = value;
                        size = 0.5.tweenTo(0.625).animatedBy(controller);
                        controller.reset();
                      });
                      controller.play();
                      pageController.animateToPage(4,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },),
                    ChooseGenderWidget(
                        onNext: (value){

                          setState(() {
                            index = index +1;
                            identityViewModel.gender = value;
                            size = 0.625.tweenTo(0.75).animatedBy(controller);
                            controller.reset();
                          });
                          controller.play();
                          pageController.animateToPage(5,
                              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                        }
                    ),
                    EnterDOBWidget(
                      onNext: (value){
                        setState(() {
                          index = index +1;
                          identityViewModel.dob = value;
                          size = 0.75.tweenTo(0.875).animatedBy(controller);
                          controller.reset();
                        });
                        controller.play();
                        pageController.animateToPage(6,
                            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                    ),
                    VerifCodeWidget(
                        onNext: (){
                          setState(() {
                            index = index +1;
                            size = 0.875.tweenTo(1.0).animatedBy(controller);
                            controller.reset();
                          });
                          controller.play();
                          pageController.animateToPage(7,
                              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                        }
                    ),
                    CreatePinWidget(
                        onNext: (){

                        }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool goBack() {
    setState(() {
      var previousIndex = index;
      index = index -1;
      // print("lllll ${0.125 * (previousIndex+1)}");
      // print("44444 ${0.125 * (index+1)}");
      size = (0.125 * (previousIndex+1)).tweenTo(0.125 * (index+1)).animatedBy(controller);
      controller.reset();
    });
    controller.play();
    pageController.animateToPage( index.toInt(),
        duration: Duration(milliseconds: 500),curve: Curves.easeIn);
        return false;
  }
}


