import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/next_of_kin.dart';
import 'package:zimvest/new_screens/profile/verification_details_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';

class AccountScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AccountScreen(),
        settings:
        RouteSettings(name: AccountScreen().toStringShort()));
  }
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with AfterLayoutMixin<AccountScreen> {
  String _selectedGender;
  DateTime _dob;

  ABSIdentityViewModel identityViewModel;
  ABSSettingsViewModel settingsViewModel;

  @override
  void afterFirstLayout(BuildContext context) {
    if(settingsViewModel.profile.gender == 1){
        _selectedGender ="Male";
    }else if(settingsViewModel.profile.gender == 2){
        _selectedGender ="Female";
    }

    _dob = settingsViewModel.profile.dob;

    setState(() {

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
                onTap: (){},
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kPrimaryColorLight
                  ),child: Center(child: SvgPicture.asset("images/new/camera.svg"),),
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
                  initialValue: "${settingsViewModel.profile.lastName} ${settingsViewModel.profile.firstName}",
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                          fontSize: 14
                      )
                  ),
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
                    initialValue: settingsViewModel.profile.email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                            fontSize: 14
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
                    initialValue: settingsViewModel.profile.phoneNumber,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                            fontSize: 14
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
    hint: Text('Please choose a Gender'),
                    onChanged: (String newValue) {
                      setState(() => _selectedGender = newValue);

                    },
                    items: ['Male',"Female"]
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
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
                        "${_dob.year}"
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
              YMargin(50),
          ],),
        ),
      ),
    );
  }
}
