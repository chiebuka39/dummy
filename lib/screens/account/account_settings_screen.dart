import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/kin_form_widget.dart';
import 'package:zimvest/widgets/kyc_form_widget.dart';
import 'package:zimvest/widgets/notification_form_widget.dart';

class AccountSettingScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AccountSettingScreen(),
        settings: RouteSettings(name: AccountSettingScreen().toStringShort()));
  }
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {

  bool showProfile = true;
  bool showBvn = false;
  bool showKYC = false;
  bool showKin = false;
  bool showNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf8fbfb),
      body: Column(
        children: [
          Container(
            height: 120,
            color: AppColors.kWhite,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                YMargin(15),
                Row(
                  children: [
                    Container(
                      child: Row(children: [
                        XMargin(20),
                        Icon(Icons.arrow_back_ios, color: AppColors.kAccentColor,size: 18,),
                        XMargin(3),
                        Text("Go back",style: TextStyle(fontSize: 12, color: AppColors.kAccentColor),)
                      ],),
                    ),
                    Spacer(),
                    CircularProfileAvatar(
                      AppStrings.avatar,
                      radius: 17,
                    ),
                    XMargin(20)
                  ],
                ),
                YMargin(15),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Account Settings", style: TextStyle(fontFamily: "Caros-Bold", fontSize: 16),),
                )

              ],),
            ),
          ),
          Expanded(child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: [
            AccountSectionHeader(title: "Profile Information",onTap: (){
              setState(() {
                showProfile = !showProfile;
              });
            },show: showProfile,),
            showProfile ? ProfileFormWidget(): SizedBox(),
            AccountSectionHeader(title: "BVN Information",onTap: (){
              setState(() {
                showBvn = !showBvn;
              });
            },show: showBvn,),
             showBvn ? BvnFormWidget(): SizedBox(),
              AccountSectionHeader(title: "Next of kin information",onTap: (){
                setState(() {
                  showKin = !showKin;
                });
              },show: showKin,),
              showKin ? KinFormWidget():SizedBox(),
              AccountSectionHeader(title: "Notification Settings",onTap: (){
                setState(() {
                  showNotifications = !showNotifications;
                });
              },show: showNotifications,),
              showNotifications ? NotificationFormWidget():SizedBox(),
              AccountSectionHeader(title: "KYC Information",onTap: (){
                setState(() {
                  showKYC = !showKYC;
                });
              },show: showKYC,attention: true,),
              showKYC ? KYCFormWidget(): SizedBox()
          ],),),

        ],
      ),
    );
  }
}

class AccountSectionHeader extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool show;
  final bool attention;
  const AccountSectionHeader({
    Key key, this.onTap, this.title, this.show = false, this.attention = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20,top: 20),
      padding: EdgeInsets.symmetric(horizontal: 14),
      height: 48,
      decoration: BoxDecoration(
          boxShadow: AppUtils.getBoxShaddow,
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Row(children: [
        Expanded(child: Text(title)),
        SvgPicture.asset("images/${attention ? 'attention':'green_check'}.svg"),
        XMargin(45),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 48,
            child: Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: show ? Container(
                  margin: EdgeInsets.only(right: 6.5,left: 6.5),
                  width: 13,
                  height: 3,
                  color: AppColors.kAccentColor,
                ): Icon(Icons.add,color: AppColors.kAccentColor,),
              ),
            ),
          ),
        )
      ],),
    );
  }
}

class ProfileFormWidget extends StatefulWidget {
  @override
  _ProfileFormWidgetState createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  bool _firstNameError = false;

  bool _lastNameError = false;

  String _firstName;

  String _lastName;

  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        YMargin(20),
        TextWidgetBorder(title: "First name",textColor: Colors.black,onChange: (value){
          if(value.length < 2){
            _firstNameError = true;
          }else{
            _firstNameError = false;
          }
          _firstName = value;
          setState(() {});
        },error: autoValidate ? _firstNameError: false,),

        TextWidgetBorder(title: "Last name", onChange: (value){
          if(value.length < 2){
            _lastNameError = true;
          }else{
            _lastNameError = false;
          }
          _lastName = value;
          setState(() {});
        },error: autoValidate ? _lastNameError: false,textColor: Colors.black,),
        TextWidgetBorder(title: "Email",textColor: Colors.black,),
        TextWidgetBorder(title: "Phone Number",textColor: Colors.black,),
        DateOfBirthBorderInputWidget(title: "Date of Birth",textColor: Colors.black,),
        DropdownBorderInputWidget(title: "Gender",
          textColor: Colors.black,items: ["Male", "Female"],),
        DropdownBorderInputWidget(title: "Marital Status",textColor: Colors.black,
          items: ["Married", "Single","Engaged"],),
        YMargin(10),
        PrimaryButton(
          title: "Update",
          onPressed: (){},
        ),
        YMargin(20)

      ],),
    );
  }
}

class BvnFormWidget extends StatefulWidget {
  @override
  _BvnFormWidgetState createState() => _BvnFormWidgetState();
}

class _BvnFormWidgetState extends State<BvnFormWidget> {
  bool _bvnError = false;

  String _bvnName;


  bool autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        YMargin(20),
        PrimaryButton(
          color: AppColors.kPrimaryColor,
          title: "Your BVN is 000000000",
          onPressed: (){},
        ),
        YMargin(20),

        TextWidgetBorder(title: "BVN",textColor: Colors.black,),

        PrimaryButton(
          title: "Update",
          onPressed: (){},
        ),
        YMargin(20)

      ],),
    );
  }
}

