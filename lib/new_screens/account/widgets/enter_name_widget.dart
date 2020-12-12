import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/buttons.dart';

class EnterNameWidget extends StatefulWidget {
  const EnterNameWidget({
    Key key, this.onNext,
  }) : super(key: key);
  final Function onNext;

  @override
  _EnterNameWidgetState createState() => _EnterNameWidgetState();
}

class _EnterNameWidgetState extends State<EnterNameWidget> {
  String firstName = "";
  String lastName = "";

  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(50),
            Text("Enter Your Legal Name"),
            YMargin(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightText,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: TextField(
                  onChanged: (value){
                    setState(() {
                      firstName = value;
                    });
                  },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "First Name",
                    hintStyle: TextStyle(
                        fontSize: 14
                    )
                ),
              ),
            ),
            if (autoValidate == false ? false : firstName.length < 2) Padding(
              padding: const EdgeInsets.only(left: 5,top: 5),
              child: Text("First name must be at least 2 characters", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
            ) else SizedBox(),
            YMargin(30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kLightText,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: TextField(
                onChanged: (value){
                  setState(() {
                    lastName = value;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Last Name",
                    hintStyle: TextStyle(
                        fontSize: 14
                    )
                ),
              ),
            ),
            if (autoValidate == false ? false : lastName.length < 2) Padding(
              padding: const EdgeInsets.only(left: 5,top: 5),
              child: Text("Last name must be at least 2 characters", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
            ) else SizedBox(),
            YMargin(100),

            RoundedNextButton(
              onTap: (){
                setState(() {
                  autoValidate = true;
                });
                if(firstName.length < 2 || lastName.length <2){
                  return;
                }
                widget.onNext(firstName,lastName);
              },
            ),
            YMargin(120)
          ],),
      ),
    );
  }
}