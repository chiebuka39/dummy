import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';

class NotificationFormWidget extends StatefulWidget {
  @override
  _NotificationFormWidgetState createState() => _NotificationFormWidgetState();
}

class _NotificationFormWidgetState extends State<NotificationFormWidget> {
  bool _receiveEmailForInvestment = false;
  bool _receiveEmailForSavings = false;
  bool _receiveNewsLetter = true;





  @override
  Widget build(BuildContext context) {
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
          )


      ],),
    );
  }
}

