import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/identity_upload_screens.dart';
import 'package:zimvest/new_screens/profile/preview_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
import 'package:zimvest/new_screens/profile/widgets/verification_failed_widget.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class VerificationNeeded extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (_) => VerificationNeeded(

      ),
      settings: RouteSettings(
        name: VerificationNeeded().toStringShort(),
      ),
    );
  }
  @override
  _VerificationNeededState createState() => _VerificationNeededState();
}

class _VerificationNeededState extends State<VerificationNeeded> {
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;

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
    final pickedFile = await picker.getImage(source: ImageSource.camera);


    if (pickedFile != null) {
      Navigator.pushReplacement(context, PreviewScreen.route(File(pickedFile.path)));
    } else {
      print('No image selected.');
    }

  }
  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        icon: Icons.clear,
        callback: (){
          Navigator.pop(context);
        },
        text: "",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text("You need to complete your verification "
                "before you  can continue",style: TextStyle(fontSize: 16,
                fontFamily: AppStrings.fontBold, height: 1.7),),
          ),
          YMargin(30),
          ProfileWidget(
            padding: 0,
            onClick: (){
              //Navigator.push(context, NextOfKinScreen.route());
              if(settingsViewModel.completedSections
                  .isBvnProvided){
                return;
              }
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return EnterBVNWidget();
              }, isScrollControlled: false);
            },
            title: "BVN Verification",
            approved: settingsViewModel.completedSections
                .kycValidationCheck.isBvnValid,
            pending:settingsViewModel.completedSections
                .kycValidationCheck.isBvnValid ? false:  settingsViewModel.completedSections
                .isBvnProvided ,
            showNext: settingsViewModel.completedSections
                .isBvnProvided ==  false,
          ),
          ProfileWidget(
            onClick: (){
              if(settingsViewModel.completedSections
                  .kycValidationCheck.identificationStatus == 1 ||settingsViewModel.completedSections
                  .kycValidationCheck.identificationStatus == 0 ){
                return;
              }
              Navigator.push(context, IdentityUploadScreen.route());
            },
            title: "Identity Verification",
            rejected: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 2 ,
            approved: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 1,
            pending: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 0,
            showNext: settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 1 || settingsViewModel.completedSections
                .kycValidationCheck.identificationStatus == 0 ? false:true,
            padding: 0,
          ),ProfileWidget(
            onClick: (){
              if(settingsViewModel.completedSections
                  .kycValidationCheck.utilityBillStatus == 1 ||settingsViewModel.completedSections
                  .kycValidationCheck.utilityBillStatus == 0 ){
                return;
              }
              settingsViewModel.selectedIdentity = null;
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,
                    onGallery: getImageFromGallery,title: "Utility Bill");
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
                .kycValidationCheck.utilityBillStatus == 1 ||settingsViewModel.completedSections
                .kycValidationCheck.utilityBillStatus == 0  ? false:true,
            padding: 0,
          ),
        ],),
      ),
    );

  }
}
