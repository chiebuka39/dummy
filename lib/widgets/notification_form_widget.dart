import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class NotificationFormWidget extends StatefulWidget {
  @override
  _NotificationFormWidgetState createState() => _NotificationFormWidgetState();
}

class _NotificationFormWidgetState extends State<NotificationFormWidget> with AfterLayoutMixin<NotificationFormWidget> {
  bool _receiveEmailForInvestment = false;
  bool _receiveEmailForSavings = false;
  bool _receiveNewsLetter = false;

  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;



  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    var result = await settingsViewModel.getNotificationSettings(token: identityViewModel.user.token);
    if (result.error == false ) {

      setState(() {
        _receiveEmailForInvestment = result.data.receiveEmailUpdateOnInvestment;
         _receiveEmailForSavings = result.data.receiveEmailUpdateOnSavings;
         _receiveNewsLetter = result.data.subscribeToNewsLetter;
      });

      EasyLoading.showSuccess("Success");
    } else {
      EasyLoading.showError("Error");
    }
  }



  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        YMargin(20),
        Text("Manage the kind of messages you get from us",
          style: TextStyle(fontSize: 10, color: AppColors.kPrimaryColor),),
          YMargin(20),
          Container(
            height: 50,
            child: Row(children: [
              Text("Receive Email updates on investment", 
                style: TextStyle(color: AppColors.kPrimaryColor),),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(value: _receiveEmailForInvestment,
                  onChanged: (bool value) {
                  setState(() {
                    _receiveEmailForInvestment = value;
                  });
                  },
                  activeColor: AppColors.kAccentColor,

                ),
              )
            ],),
          ),
          Container(
            height: 50,
            child: Row(children: [
              Text("Receive Email updates on Savings",
                style: TextStyle(color: AppColors.kPrimaryColor),),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(value: _receiveEmailForSavings,
                  onChanged: (bool value) {
                  setState(() {
                    _receiveEmailForSavings = value;
                  });
                  },
                  activeColor: AppColors.kAccentColor,

                ),
              )
            ],),
          ),
          Container(
            height: 50,
            child: Row(children: [
              Text("Subscribe to our news letter",
                style: TextStyle(color: AppColors.kPrimaryColor),),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(value: _receiveNewsLetter,
                  onChanged: (bool value) {
                  setState(() {
                    _receiveNewsLetter = value;
                  });
                  },
                  activeColor: AppColors.kAccentColor,

                ),
              )
            ],),
          ),
          YMargin(20),
          PrimaryButton(
            title: "Update",
            onPressed: (){},
          ),
          YMargin(20)


      ],),
    );
  }
}

