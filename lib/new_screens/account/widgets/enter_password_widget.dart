import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterPasswordWidget extends StatefulWidget {
  const EnterPasswordWidget({
    Key key, this.onNext,
  }) : super(key: key);

  final VoidCallback onNext;

  @override
  _EnterPasswordWidgetState createState() => _EnterPasswordWidgetState();
}

class _EnterPasswordWidgetState extends State<EnterPasswordWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          hintText: "Email Password",
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
          YMargin(10),
          Row(children: [
            Text("At least 8+ character", style: TextStyle(fontSize: 9),),
            YMargin(2),
            Icon(Icons.check, size: 10,),
            Spacer(),
            Text("At least 1 number", style: TextStyle(fontSize: 9),),
            YMargin(2),
            Icon(Icons.check, size: 10,),
            Spacer(),
            Text("At least one symbol", style: TextStyle(fontSize: 9),),
            YMargin(2),
            Icon(Icons.check, size: 10,),
          ],),
          Spacer(),
          RoundedNextButton(
            onTap: widget.onNext,
          ),
          YMargin(120)

        ],),
    );
  }

  String specialChar =
      r'^(?=.*?[)(\][)(|:};{?.="\u0027%!+<@>#\$/&*~^_-`,\u005C\u002D])';

  String oneNumber = r'^(?=.*?[0-9])';
  final caps1 = RegExp(r'^[a-zA-Z0-9]+$');
  final caps = RegExp(r'^(?=.*?[A-Z])',unicode: true);
  bool isValidPass(String password) {

    bool hasNum = RegExp(oneNumber,unicode: true).hasMatch(password);
    bool hasSpecial = RegExp(specialChar,unicode: true).hasMatch(password);

    //print("regex $hasCaps $hasLower $hasSpecial ${password.length >= 8}");
    return  hasSpecial == true && hasNum == true && password.length >= 8;
  }

}