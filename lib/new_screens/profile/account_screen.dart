import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/models/individual/profile.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/next_of_kin.dart';
import 'package:zimvest/new_screens/profile/verification_details_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class AccountScreen extends StatefulWidget {
  final Profile profile;

  const AccountScreen({Key key, this.profile}) : super(key: key);
  static Route<dynamic> route({Profile profile}) {
    return MaterialPageRoute(
        builder: (_) => AccountScreen(profile: profile,),
        settings:
        RouteSettings(name: AccountScreen().toStringShort()));
  }
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with AfterLayoutMixin<AccountScreen> {
  String _selectedGender;
  DateTime _dob;
  File _image;
  String _fullName;
  String _email;
  String _phone;
  final picker = ImagePicker();

  ABSIdentityViewModel identityViewModel;
  ABSSettingsViewModel settingsViewModel;

  int gender = 1;

  bool loading = false;

  @override
  void initState() {
    try{
      _dob = widget.profile.dob;
      _phone = widget.profile.phoneNumber.substring(4);
      _email = widget.profile.email;
      _fullName = widget.profile.firstName + " " + widget.profile.lastName;
    }catch(e){

    }


    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if(settingsViewModel.profile.gender == 1){
        _selectedGender ="Male";
    }else if(settingsViewModel.profile.gender == 2){
        _selectedGender ="Female";
    }


    setState(() {

    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    identityViewModel = Provider.of(context);
    settingsViewModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:AppColors.kTextColor),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(icon: Icon(Icons.navigate_before_rounded, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("Account", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(
              child: InkWell(
                onTap: getImage,
                child: _image == null ? Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimaryColorLight
                  ),child: Center(child: SvgPicture.asset("images/new/camera.svg"),),
                ):Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(_image),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
              ),
            ),
            YMargin(5),
            Center(child: Text("Tap to change picture", style: TextStyle(fontSize: 10),)),
            YMargin(40),
              Text("full name".toUpperCase(), style: TextStyle(fontSize: 11),),
            YMargin(15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Transform.translate(
                offset: Offset(0,5),
                child: TextFormField(
                  initialValue: _fullName,
                  style: TextStyle(fontSize: 13,
                      fontFamily: AppStrings.fontNormal, color: AppColors.kTextColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Full Name",

                      hintStyle: TextStyle(
                          fontSize: 13,
                        fontFamily: AppStrings.fontNormal,
                        color: AppColors.kSecondaryColor.withOpacity(0.64)
                      )
                  ),
                  onChanged: (value){
                    setState(() {
                      _fullName = value;
                    });
                  },
                ),
              ),
            ),
              YMargin(25),
              Text("Email Address".toUpperCase(), style: TextStyle(fontSize: 11),),
              YMargin(15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Transform.translate(
                  offset: Offset(0,5),
                  child: TextFormField(
                    initialValue:_email,
                    onChanged: (value){
                      setState(() {
                        _email = value;
                      });
                    },
                      style: TextStyle(fontSize: 13,
                          fontFamily: AppStrings.fontNormal, color: AppColors.kTextColor),

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email Address",
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kSecondaryColor.withOpacity(0.64)
                      )
                    ),
                  ),
                ),
              ),
              YMargin(25),
              Text("Phone Number".toUpperCase(), style: TextStyle(fontSize: 11),),
              YMargin(15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Transform.translate(
                  offset: Offset(0,5),
                  child: TextFormField(
                    onChanged: (value){
                      setState(() {
                        _phone = value;
                      });
                    },
                    initialValue: _phone,
                      style: TextStyle(fontSize: 13,
                          fontFamily: AppStrings.fontNormal, color: AppColors.kTextColor),

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: AppStrings.fontNormal,
                          color: AppColors.kSecondaryColor.withOpacity(0.64)
                      )
                    ),
                  ),
                ),
              ),
              YMargin(25),
              Text("Gender".toUpperCase(), style: TextStyle(fontSize: 11),),
              YMargin(15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.kGreyBg,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: _selectedGender,
                    isDense: true,
    hint: Text('Please choose a Gender', style: TextStyle(fontSize: 13,fontFamily: AppStrings.fontNormal, color: AppColors.kTextColor),),
                    onChanged: (String newValue) {
                      setState(() {

                        _selectedGender = newValue;
                        if(_selectedGender == "Male"){
                          gender = 1;
                        }else{
                          gender = 2;
                        }
                      });

                    },
                    items: ['Male',"Female"]
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value, style: TextStyle(fontSize: 13,
                            fontFamily: AppStrings.fontNormal),),
                      );
                    })
                        .cast<DropdownMenuItem<String>>()
                        .toList(),
                  ),
                ),
              ),
              YMargin(25),
              Text("Date of birth".toUpperCase(), style: TextStyle(fontSize: 11),),
              YMargin(15),
              InkWell(
                onTap: ()async{
                  DateTime dob = await showDatePicker(context: context, initialDate: DateTime(1990),
                      firstDate: DateTime(1920), lastDate: DateTime(2040));
                  if(dob != null){
                    setState(() {
                      _dob = dob;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.kGreyBg,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(children: [
                    _dob == null? SizedBox():Text(""
                        "${AppUtils.addLeadingZeroIfNeeded(_dob.month)}/"
                        "${AppUtils.addLeadingZeroIfNeeded(_dob.day)}/"
                        "${_dob.year}",style: TextStyle(fontSize: 13,
                        fontFamily: AppStrings.fontNormal, color: AppColors.kTextColor),
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down_rounded)
                  ],),
                ),
              ),
              YMargin(5),
              ProfileWidget(
                padding: 0,
                onClick: (){
                  Navigator.push(context, NextOfKinScreen.route());
                },
                title: "Next of Kin",
              ),
              ProfileWidget(
                onClick: (){
                  Navigator.push(context, VerificationDetailsScreen.route());
                },
                title: "Verification details",
                emergency: true,
                padding: 0,
              ),
              YMargin(20),
              Center(
                child: PrimaryButtonNew(
                  title: 'Save',
                  loading: loading,
                  onTap:_fullName.isNotEmpty && _email.isNotEmpty
                      && _phone.isNotEmpty && _dob != null && _image != null ?  ()async{
                    EasyLoading.show(status: "");
                    var result = await settingsViewModel.updateProfile(
                      profile1: _image,
                      dOB: _dob.toIso8601String(),
                      phoneNumber: "+234"+_phone,
                      firstName: _fullName.split(" ").last,
                      lastName: _fullName.split(" ").first,
                      gender: gender,
                      email: _email
                    );
                    if(result.error == false){
                      EasyLoading.dismiss();
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return PasswordSuccessWidget(
                          message: "Profile was updated successful",
                          onDone: (){
                            Navigator.pop(context);

                          },
                        );
                      },isDismissible: false);
                    }else{
                      EasyLoading.dismiss();
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return PasswordSuccessWidget(
                          success: false,
                          message: "Profile was not updated succesfully",
                          onDone: (){
                            Navigator.pop(context);

                          },
                        );
                      },isDismissible: false);
                    }
                  }:null,
                ),
              ),
              YMargin(50),
          ],),
        ),
      ),
    );
  }
}
