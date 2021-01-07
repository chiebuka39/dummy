import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/validator.dart';
import 'package:zimvest/widgets/buttons.dart';

class NextOfKinScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => NextOfKinScreen(),
        settings:
        RouteSettings(name: NextOfKinScreen().toStringShort()));
  }
  @override
  _NextOfKinScreenState createState() => _NextOfKinScreenState();
}

class _NextOfKinScreenState extends State<NextOfKinScreen> {
  String _selectedGender;

  DateTime _dob;

  String fullName = '';

  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;

  bool autoValidate = false;

  String email = '';

  String phone = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:AppColors.kTextColor),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(icon: Icon(Icons.close, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("Next of kin", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  initialValue: settingsViewModel.kin.fullName,
                  onChanged: (value){
                    setState(() {
                      fullName = value;
                    });
                  },
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
            if (autoValidate == false ? false : fullName.length < 2) Padding(
              padding: const EdgeInsets.only(left: 5,top: 5),
              child: Text("Full name", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
            ) else SizedBox(),
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
                  initialValue: settingsViewModel.kin.email,
                  onChanged: (value){
                    setState(() {
                      email = value;
                    });
                  },
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


              if (autoValidate == false ? false : EmailValidator.validate(email) == false) Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text("Email is incorrect", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
              ) else SizedBox(),
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
                  initialValue: settingsViewModel.kin.phoneNumber,
                  onChanged: (value){
                    setState(() {
                      phone = value;
                    });
                  },
                  keyboardType: TextInputType.phone,
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
              if (autoValidate == false ? false : phone.length != 10 && phone.length != 11) Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: Text("Phone number is incorrect", style: TextStyle(fontSize: 11,color: AppColors.kRed),),
              ) else SizedBox(),
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
                  hint: Text('Choose a Gender', style: TextStyle(fontSize: 13),),
                        onChanged: (String newValue) {
                        print("popp ${newValue}");
                        setState(() {
                        _selectedGender = newValue;
                        });

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
            Text("Relationship".toUpperCase(), style: TextStyle(fontSize: 11),),
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
                    value: "Father",
                    isDense: true,
                    hint: Text('What’s your relationship', style: TextStyle(fontSize: 13),),
                    onChanged: (String newValue) {
                      print("popp ${newValue}");
                      setState(() {
                        //_selectedGender = newValue;
                      });

                    },
                    items: ['Father',"Mother", 'Sister',"Brother"]
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
              YMargin(58),
              Center(
                child: PrimaryButtonNew(
                  loading: loading,
                  title: "Save",
                  onTap: ()async{
                    if(fullName.length < 2 || EmailValidator.validate(email) == false || phone.length <10 || phone.length >11){
                      setState(() {
                        autoValidate = true;
                      });
                      return;
                    }
                    setState(() {
                      loading = true;
                    });
                    var result = await settingsViewModel.updateKin(
                      token: identityViewModel.user.token,
                      fullName: fullName,
                      email: email,
                      phoneNumber: phone,
                      relationship:1
                    );
                    setState(() {
                      loading = false;
                    });
                    if(result.error == false){
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return NextOfKinStatus(success: true,);
                      });
                    }else{
                      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                        return NextOfKinStatus(success: false,);
                      });
                    }


                  },
                ),
              ),
              YMargin(58),

          ],),
        ),
      ),
    );
  }
}
