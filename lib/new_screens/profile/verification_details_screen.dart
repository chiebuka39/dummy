import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimvest/new_screens/profile/preview_screen.dart';
import 'package:zimvest/new_screens/profile/residential_screen.dart';
import 'package:zimvest/new_screens/profile/widgets/profile_widgets.dart';
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
            },
            title: "BVN Verification",
          ),
          ProfileWidget(
            onClick: (){
              Navigator.push(context, ResidentialScreen.route());
            },
            title: "Residential Address",
            emergency: true,
            padding: 0,
          ),
          ProfileWidget(
            onClick: (){
              //Navigator.push(context, IdentityVerificationScreen.route());
            },
            title: "Identity document",
            emergency: true,
            padding: 0,
          ),
          ProfileWidget(
            onClick: (){
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,onGallery: getImageFromGallery,);
              }, isScrollControlled: true);
              //Navigator.push(context, IdentityVerificationScreen.route());
            },
            title: "Utility Bill",
            emergency: true,
            padding: 0,
          ),
        ],),
      ),
    );
  }
}
