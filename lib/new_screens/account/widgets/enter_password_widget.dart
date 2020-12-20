import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterPasswordWidget extends StatefulWidget {
  const EnterPasswordWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final Function onNext;

  @override
  _EnterPasswordWidgetState createState() => _EnterPasswordWidgetState();
}

class _EnterPasswordWidgetState extends State<EnterPasswordWidget> {
  bool obscureText = true;
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Create Your Password"),
            YMargin(30),
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
                            password = value;
                          });
                        },
                        obscureText: obscureText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontSize: 14
                            )
                        ),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon( obscureText ? Icons.visibility_off:Icons.visibility,size: 20,), onPressed: (){
                    setState(() {
                      obscureText = !obscureText;
                    });
                  })
                ],
              ),
            ),
            YMargin(10),
            Row(children: [
              password.length >= 8 ?PasswordCheck(title: '8+ characters',)
                  :PasswordError(title: '8+ characters',),
              XMargin(5),
              hasSpecial(password) ? PasswordCheck(title: '1 Special Character',flex: 3,)
                  :PasswordError(title: '1 Special Character',flex: 3,),
              XMargin(5),
              hasNum(password) ?PasswordCheck(title: '1+ Number',)
                  : PasswordError(title: '1+ Number',),


            ],),
           YMargin(100),
            RoundedNextButton(
              onTap: (){
                if(isValidPass(password)){
                  widget.onNext(password);
                }
              },
            ),
            YMargin(120)

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

class PasswordCheck extends StatelessWidget {
  const PasswordCheck({
    Key key, this.title, this.flex = 2,
  }) : super(key: key);
  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.kFixed.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              SvgPicture.asset("images/new/p_check.svg"),
              XMargin(5),
              Text(title, style: TextStyle(fontSize: 9),),
            ],
          )),
    );
  }
}
class PasswordError extends StatelessWidget {
  const PasswordError({
    Key key, this.title, this.flex = 2,
  }) : super(key: key);
  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
          height: 22,
          decoration: BoxDecoration(
            color: AppColors.kWealth.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              SvgPicture.asset("images/new/p_error.svg"),
              XMargin(5),
              Text(title, style: TextStyle(fontSize: 9),),
            ],
          )),
    );
  }
}