import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
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
  @override
  void initState() {
    controller.duration = Duration(milliseconds: 300);
    size = value.tweenTo(0.25).animatedBy(controller); // <-- connect tween and controller and apply to animation variable
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.navigate_before_rounded,size: 26,color: AppColors.kPrimaryColor,),
          onPressed: (){
            Navigator.pop(context);
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
                controller: pageController,
                children: [

                  EnterMailWidget(
                    onNext: (){

                      controller.play();


                      pageController.animateToPage(1,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  ),
                  EnterPasswordWidget(
                    onNext: (){
                      setState(() {
                        size = 0.25.tweenTo(0.375).animatedBy(controller);
                        controller.reset();
                      });
                      controller.play();
                      pageController.animateToPage(2,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  ),
                  EnterNameWidget(
                    onNext: (){
                      setState(() {
                        size = 0.375.tweenTo(0.5).animatedBy(controller);
                        controller.reset();
                      });
                      controller.play();
                      pageController.animateToPage(3,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  ),
                  EnterPhoneWidget(
                    onNext: (){
                    setState(() {
                      size = 0.5.tweenTo(0.625).animatedBy(controller);
                      controller.reset();
                    });
                    controller.play();
                    pageController.animateToPage(4,
                        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  },),
                  ChooseGenderWidget(
                      onNext: (){
                        setState(() {
                          size = 0.625.tweenTo(0.75).animatedBy(controller);
                          controller.reset();
                        });
                        controller.play();
                        pageController.animateToPage(5,
                            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      }
                  ),
                  EnterDOBWidget(
                    onNext: (){
                      setState(() {
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
    );
  }
}


