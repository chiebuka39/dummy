import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class KinFormWidget extends StatefulWidget {
  @override
  _KinFormWidgetState createState() => _KinFormWidgetState();
}

class _KinFormWidgetState extends State<KinFormWidget> {
  bool _idError = false;

  File _govtId;
  File _utilityId;


  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        YMargin(20),
        Text("Your next of kin who is your closest living blood "
            "relative is very important. In a case where we are unable to reach "
            "you for a long period of time, "
            "or if  the person dies, your next-of-kin would be contacted.", style: TextStyle(fontSize: 10,color: AppColors.kPrimaryColor),),
        YMargin(20),

        TextWidgetBorder(title: "Next of Kin Fullname",
          textColor: Colors.black,labelSize: 12,),
        DropdownBorderInputWidget(
          title: "Relationship",
          items: ["Wife", "Husband", "Child","Cousin"],textColor: Colors.black,
        ),
        TextWidgetBorder(title: "Email of Next of kin",
          textColor: Colors.black,labelSize: 12,),
        TextWidgetBorder(title: "Phone number of next of kin",
          textColor: Colors.black,labelSize: 12,),

        PrimaryButton(
          title: "Update",
          onPressed: (){},
        ),
        YMargin(20)

      ],),
    );
  }
}

