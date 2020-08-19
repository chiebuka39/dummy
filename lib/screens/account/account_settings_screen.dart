import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/completed_sections.dart';
import 'package:zimvest/data/models/individual/profile.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/account_widgets.dart';
import 'package:zimvest/widgets/appbars.dart';
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

class _AccountSettingScreenState extends State<AccountSettingScreen> with AfterLayoutMixin<AccountSettingScreen> {
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;
  bool showProfile = false;
  bool showBvn = false;
  bool showKYC = false;
  bool showKin = false;
  bool showNotifications = false;
  CompletedSections _completedSections;

  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    var i1 = await settingsViewModel.getCompletedSections(token: identityViewModel.user.token);
    if (i1.error == false ) {

      setState(() {
        _completedSections = i1.data;
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
    return Scaffold(
      backgroundColor: Color(0xFFf8fbfb),
      appBar: ZimAppBar(
        title: "Account settings",
      ),
      body: _completedSections == null ? SizedBox(): ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
        AccountSectionHeader(title: "Profile Information",onTap: (){
          setState(() {
            showProfile = !showProfile;
          });
        },show: showProfile,attention: !_completedSections.isProfileInformationProvided,),
        showProfile ? ProfileFormWidget(): SizedBox(),
        AccountSectionHeader(title: "BVN Information",onTap: (){
          setState(() {
            showBvn = !showBvn;
          });
        },show: showBvn,attention: !_completedSections.isBvnProvided),
         showBvn ? BvnFormWidget(): SizedBox(),
          AccountSectionHeader(title: "Next of kin information",onTap: (){
            setState(() {
              showKin = !showKin;
            });
          },show: showKin,attention: !_completedSections.isNextOfKinProvided),
          showKin ? KinFormWidget():SizedBox(),
          AccountSectionHeader(title: "Notification Settings",onTap: (){
            setState(() {
              showNotifications = !showNotifications;
            });
          },show: showNotifications,attention: !_completedSections.isNotificationConfigured),
          showNotifications ? NotificationFormWidget():SizedBox(),
          AccountSectionHeader(title: "KYC Information",onTap: (){
            setState(() {
              showKYC = !showKYC;
            });
          },show: showKYC,attention: !_completedSections.isKycProvided),
          showKYC ? KYCFormWidget(): SizedBox()
      ],),
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

class _ProfileFormWidgetState extends State<ProfileFormWidget> with AfterLayoutMixin<ProfileFormWidget> {
  bool _firstNameError = false;

  bool _lastNameError = false;

  String _firstName;

  String _lastName;

  int gender = 1;
  int maritalStatus = 1;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime dob;

  bool autoValidate = false;
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;



  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    var i1 = await settingsViewModel.getProfileDetail(token: identityViewModel.user.token);
    if (i1.error == false ) {
      firstNameController.text = i1.data.firstName;
      lastNameController.text = i1.data.lastName;
      emailController.text = i1.data.email;
      phoneController.text = i1.data.phoneNumber;
      setState(() {
        dob = i1.data.dob;
        maritalStatus = i1.data.maritalStatus;
        gender = i1.data.gender;
      });
      EasyLoading.showSuccess("Success");
    } else {
      EasyLoading.showError("Error");
    }
  }
  final genderList = ["Male", "Female"];
  final maritalList = ["Single","Married"];

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);

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
        },error: autoValidate ? _firstNameError: false,
         controller: firstNameController,
        ),

        TextWidgetBorder(title: "Last name", onChange: (value){
          if(value.length < 2){
            _lastNameError = true;
          }else{
            _lastNameError = false;
          }
          _lastName = value;
          setState(() {});
        },
          controller: lastNameController,
          error: autoValidate ? _lastNameError: false,textColor: Colors.black,),
        TextWidgetBorder(title: "Email",
          textColor: Colors.black,
          controller: emailController,
        ),
        TextWidgetBorder(title: "Phone Number",textColor: Colors.black,
          keyboardType: TextInputType.phone,
          controller: phoneController,
        ),
        DateOfBirthBorderInputWidget(
          title: "Date of Birth",textColor: Colors.black,
          initialDate: DateTime.utc(1930),
          selected: dob ?? DateTime.now(),
          startDate: DateTime.utc(1990), endDate: DateTime.utc(2030),
        ),
        DropdownBorderInputWidget(title: "Gender",
          textColor: Colors.black,items: genderList,
          source: genderList[gender-1],
        ),
        DropdownBorderInputWidget(title: "Marital Status",textColor: Colors.black,
          items: maritalList,
          source: maritalList[maritalStatus-1],
        ),
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

class _BvnFormWidgetState extends State<BvnFormWidget> with AfterLayoutMixin<BvnFormWidget>{
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;
  bool _bvnError = false;

  TextEditingController _bvnName = TextEditingController();


  bool autoValidate = false;

  @override
  void afterFirstLayout(BuildContext context) async{
    EasyLoading.show(status: 'loading...');
    var i1 = await settingsViewModel.getBvn(token: identityViewModel.user.token);
    if (i1.error == false ) {
      _bvnName.text = i1.data;


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
      child: Column(children: [
        YMargin(20),
        PrimaryButton(
          color: AppColors.kPrimaryColor,
          title: "Your BVN is ${_bvnName.text}",
          onPressed: (){},
        ),
        YMargin(20),

        TextWidgetBorder(title: "BVN",
          textColor: Colors.black,
          controller: _bvnName,
        ),

        PrimaryButton(
          title: "Update",
          onPressed: _bvnName.text.isEmpty ? null: (){

          },
        ),
        YMargin(20)

      ],),
    );
  }
}

