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

class VerificationDetailsScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => VerificationDetailsScreen(),
        settings:
        RouteSettings(name: VerificationDetailsScreen().toStringShort()));
  }
  @override
  _VerificationDetailsScreenState createState() => _VerificationDetailsScreenState();
}

class _VerificationDetailsScreenState extends State<VerificationDetailsScreen> {

  File _image;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Navigator.pushReplacement(context, PreviewScreen.route(File(pickedFile.path)));
    } else {
      print('No image selected.');
    }
  }
  Future getImageFromCam() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


      if (pickedFile != null) {
        Navigator.pushReplacement(context, PreviewScreen.route(File(pickedFile.path)));
      } else {
        print('No image selected.');
      }

  }

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
          child: IconButton(icon: Icon(Icons.close, color: AppColors.kPrimaryColor,), onPressed: () {
            Navigator.pop(context);
          },),
        ),
        title: Text("Verification Details", style: TextStyle(fontSize: 13,
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
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return EnterBVNWidget();
              }, isScrollControlled: false);
            },
            title: "BVN Verification",
            approved: settingsViewModel.completedSections
                .kycValidationCheck.isBvnValid ,
            pending: settingsViewModel.completedSections
                .isBvnProvided ,
            showNext: settingsViewModel.completedSections
                .kycValidationCheck.isBvnValid ==  false,
          ),
          ProfileWidget(
            onClick: (){
              Navigator.push(context, ResidentialScreen.route());
            },
            title: "Residential Address",

            padding: 0,
          ),
          ProfileWidget(
            onClick: (){
              Navigator.push(context, IdentityUploadScreen.route());
            },
            title: "Identity document",
            rejected: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 2 ,
            approved: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 1,
            pending: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 0,
            showNext: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 1 ? false:true,
            padding: 0,
          ),
          ProfileWidget(
            onClick: (){
              settingsViewModel.selectedIdentity = null;
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,onGallery: getImageFromGallery,);
              }, isScrollControlled: true);
              //Navigator.push(context, IdentityVerificationScreen.route());
            },
            title: "Utility Bill",
            rejected: settingsViewModel.completedSections
                .kycValidationCheck.utilityBillStatus == 2,
            approved: settingsViewModel.completedSections
                .kycValidationCheck.utilityBillStatus == 1,
            pending: settingsViewModel.completedSections
                .kycValidationCheck.utilityBillStatus == 0,
            showNext: settingsViewModel.completedSections
                .kycValidationCheck.utilityBillStatus == 1 ? false:true,
            padding: 0,
          ),
        ],),
      ),
    );
  }
}
