import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

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

  @override
  Widget build(BuildContext context) {
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
              Text("Good morning, Emmanuel"),
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
                    IconButton(icon: Icon(Icons.visibility_off,size: 20,), onPressed: (){})
                  ],
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

class EnableFaceIdWidget extends StatelessWidget {
  const EnableFaceIdWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(children: [
        YMargin(10),
        Center(child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
        ),),
        YMargin(20),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color:Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            YMargin(40),
            Container(
              height: 65,
              width: 63,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: AppColors.kGrey
              ),
              child: Center(child: SvgPicture.asset("images/icon_face.svg"),),
            ),
              YMargin(27),
              Text("Enable Face ID", style: TextStyle(
                fontFamily: AppStrings.fontMedium
              ),),
              YMargin(26),
              SizedBox(
                width: 250,
                child: Text("Enable Face ID for easier authentication,"
                    "you can turn this off in the setting ", style: TextStyle(
                  fontFamily: AppStrings.fontNormal,
                  height: 1.7,
                  fontSize: 11,color: AppColors.kGreyText
                ),textAlign: TextAlign.center,),
              ),
              Spacer(),
              PrimaryButtonNew(
                onTap: (){},
                title: "Yes",
                width: 200,
              ),
              YMargin(10),
              FlatButton(onPressed: (){}, child: Text("No",
                style: TextStyle(fontFamily: AppStrings.fontNormal),)),
              Spacer(),
          ],),
        ))
      ],),
    );
  }
}
