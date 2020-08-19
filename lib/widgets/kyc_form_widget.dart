import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class KYCFormWidget extends StatefulWidget {
  @override
  _KYCFormWidgetState createState() => _KYCFormWidgetState();
}

class _KYCFormWidgetState extends State<KYCFormWidget> with AfterLayoutMixin<KYCFormWidget> {
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;
  bool _idError = false;
  String _id;

  TextEditingController _addressController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    var i1 = await settingsViewModel.getResidentialAddress(token: identityViewModel.user.token);
    if (i1.error == false ) {
      _addressController.text = i1.data.residentialAddress;

      setState(() {
        _state = AppUtils.states.indexOf(i1.data.state);
      });

      EasyLoading.showSuccess("Success");
    } else {
      EasyLoading.showError("Error");
    }
  }


  bool autoValidate = false;

  String _address;

  int _state = 0;


  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        YMargin(20),
        UploadWidget(
          title: "Upload a valid Govt issued ID",
          onSave: (File file){
            if(_id == null ){
              setState(() {
                _idError = true;
              });
              return;
            }
            if(_id.length < 4){
              setState(() {
                _idError = true;
              });
              return;
            }
            _uploadID(file);
          },
        ),
        YMargin(20),

        TextWidgetBorder(
          title: "Identification number for "
            "the uploaded Government issue ID card",
          textColor: Colors.black,labelSize: 10,
          onChange: (value){
            setState(() {
              _id = value;
              if(_idError == true){
                _idError = value.length <4;
              }
            });
          },
          error: _idError,
        ),

        UploadWidget(
          title: 'Upload recent utility bill',
          onSave: (file){
            _uploadUtitlyFile(file);
          },
        ),
        YMargin(20),
        TextMultiLineWidget(title: "Residential address",
          onChange: (value){
          setState(() {
            _address = value;
          });
          },
          controller: _addressController,
        ),
        DropdownBorderInputWidget(title: "State of residence",
          items: AppUtils.states,textColor: Colors.black,

          onSelect: (value){
          setState(() {
            _state = AppUtils.states.indexOf(value);
          });

          },
          source: AppUtils.states[_state],
        ),
        PrimaryButton(
          title: "Update",
          onPressed: _state == null || _address == null ? null: ()async{
            EasyLoading.show(status: 'loading...');
            var result = await settingsViewModel.updateResidentialAddress(
                token: identityViewModel.user.token, address:_address,state: _state+1);
            if (result.error == false ) {

              EasyLoading.showSuccess("Identity Uploaded");
            } else {
              EasyLoading.showError("Error");
            }
          },
        ),
        YMargin(20)

      ],),
    );
  }

  void _uploadID(File file)async {
    EasyLoading.show(status: 'loading...');
    var result = await settingsViewModel.uploadIdentification(
        token: identityViewModel.user.token, file:file,id: _id);
    if (result.error == false ) {

      EasyLoading.showSuccess("Identity Uploaded");
    } else {
      EasyLoading.showError("Error");
    }
  }

  void _uploadUtitlyFile(File file) async{
    EasyLoading.show(status: 'loading...');
    var result = await settingsViewModel.uploadUtilityBill(
        token: identityViewModel.user.token, file:file);
    if (result.error == false ) {
      EasyLoading.showSuccess("Utility Uploaded", duration: Duration(seconds: 2));
    } else {
      EasyLoading.showError("Error");
    }
  }
}

