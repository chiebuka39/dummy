import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class KinFormWidget extends StatefulWidget {
  @override
  _KinFormWidgetState createState() => _KinFormWidgetState();
}

class _KinFormWidgetState extends State<KinFormWidget> with AfterLayoutMixin<KinFormWidget> {
  bool _idError = false;

  TextEditingController kinName = TextEditingController();
  TextEditingController kinEmail = TextEditingController();
  TextEditingController kinNumber = TextEditingController();


  bool autoValidate = false;
  int relationship = 1;

  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;



  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    var i1 = await settingsViewModel.getNextOfKin(token: identityViewModel.user.token);
    if (i1.error == false ) {
      kinName.text = i1.data.fullName;
      kinEmail.text = i1.data.email;
      kinNumber.text = i1.data.phoneNumber;
      setState(() {
        relationship = relationshipList.indexOf(i1.data.relationship);
      });
      print("ooooo ${relationship}");
      EasyLoading.showSuccess("Success");
    } else {
      EasyLoading.showError("Error");
    }
  }
  final List<String> relationshipList = ["Wife","Husband","Sister",
    "Brother","Uncle","Aunty",
    "Daughter","Son","Father","Mother",
    "Cousin", "Niece","Nephew","Friend","Others"
  ];

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
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
          textColor: Colors.black,labelSize: 12,
          controller: kinName,
        ),
        DropdownBorderInputWidget(
          title: "Relationship",
          items: relationshipList,textColor: Colors.black,
          source: relationshipList[relationship],
          onSelect: (value){
            setState(() {
              relationship = relationshipList.indexOf(value);
            });
          },
        ),
        TextWidgetBorder(
          title: "Email of Next of kin",
          textColor: Colors.black,labelSize: 12,
          controller: kinEmail,
        ),
        TextWidgetBorder(title: "Phone number of next of kin",
          textColor: Colors.black,labelSize: 12,
          controller: kinNumber,
        ),

        PrimaryButton(
          title: "Update",
          onPressed: kinName.text.isNotEmpty &&
              kinNumber.text.isNotEmpty && kinEmail.text.isNotEmpty? _updateKin:null,
        ),
        YMargin(20)

      ],),
    );
  }
  _updateKin()async{

    EasyLoading.show(status: 'loading...');
    var i1 = await settingsViewModel.updateKin(
        token: identityViewModel.user.token,
      email: kinEmail.text,
      phoneNumber: kinNumber.text,
      fullName: kinName.text,
      relationship: relationship+1
    );
    if (i1.error == false ) {
      EasyLoading.showSuccess("Success");
    } else {
      EasyLoading.showError("Error");
    }
  }
}

