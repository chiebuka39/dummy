import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class KYCFormWidget extends StatefulWidget {
  @override
  _KYCFormWidgetState createState() => _KYCFormWidgetState();
}

class _KYCFormWidgetState extends State<KYCFormWidget> {
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
        UploadWidget(),
        YMargin(20),

        TextWidgetBorder(title: "Identification number for "
            "the uploaded Government issue ID card",
          textColor: Colors.black,labelSize: 10,),

        UploadWidget(),
        YMargin(20),
        TextMultiLineWidget(title: "Residential address",),
        DropdownBorderInputWidget(title: "State of residence",
          items: ["Abia,Lagos,Ogun"],textColor: Colors.black,),
        PrimaryButton(
          title: "Update",
          onPressed: (){},
        ),
        YMargin(20)

      ],),
    );
  }
}

