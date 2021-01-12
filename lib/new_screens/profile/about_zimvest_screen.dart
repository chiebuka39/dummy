import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/identity_upload_screens.dart';
import 'package:zimvest/new_screens/profile/preview_screen.dart';
import 'package:zimvest/new_screens/profile/residential_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class AboutZimvestScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => AboutZimvestScreen(),
        settings:
        RouteSettings(name: AboutZimvestScreen().toStringShort()));
  }
  @override
  _AboutZimvestScreenState createState() => _AboutZimvestScreenState();
}

class _AboutZimvestScreenState extends State<AboutZimvestScreen> {

  File _image;

  final picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    ABSSettingsViewModel settingsViewModel = Provider.of(context);
    print("llll11 ${settingsViewModel.completedSections
        .kycValidationCheck.identificationStatus}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:AppColors.kTextColor),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(icon: Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("About Zimvest", style: TextStyle(fontSize: 13,
            fontFamily: AppStrings.fontMedium,color: AppColors.kTextColor),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          YMargin(20),
          ProfileWidget(
            padding: 0,
            onClick: (){
              //Navigator.push(context, NextOfKinScreen.route());

            },
            title: "FAQ",
            showNext: true,
          ),
          ProfileWidget(
            onClick: (){
              //Navigator.push(context, ResidentialScreen.route());
            },
            title: "Support",

            padding: 0,
          ),
          ProfileWidget(
            onClick: (){
              Navigator.push(context, IdentityUploadScreen.route());
            },
            title: "Knowledge Base",

            showNext:true,
            padding: 0,
          ),
        ],),
      ),
    );
  }
}
