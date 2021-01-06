import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/new_screens/profile/preview_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class IdentityUploadScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        builder: (_) => IdentityUploadScreen(),
        settings:
        RouteSettings(name: IdentityUploadScreen().toStringShort()));
  }
  @override
  _IdentityUploadScreenState createState() => _IdentityUploadScreenState();
}

class _IdentityUploadScreenState extends State<IdentityUploadScreen> {
  ABSSettingsViewModel settingsViewModel;

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
    settingsViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        text: "Identity Document",
        callback: (){
          Navigator.of(context).pop();
        },
        icon: Icons.arrow_back_ios,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(60),
          Text("Choose ID option", style: TextStyle(
            fontSize: 13,fontFamily: AppStrings.fontMedium
          ),),

          IdentityWidget(
            onTap: (){
              settingsViewModel.selectedIdentity = 1;
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,onGallery: getImageFromGallery,);
              }, isScrollControlled: true);
            },
          ),
          IdentityWidget(
            title: 'National identity card',
            onTap: (){
              settingsViewModel.selectedIdentity = 2;
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,onGallery: getImageFromGallery,);
              }, isScrollControlled: true);
            },
          ),
          IdentityWidget(
            title: 'International passport',
            onTap: (){
              settingsViewModel.selectedIdentity = 3;
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,onGallery: getImageFromGallery,);
              }, isScrollControlled: true);
            },
          ),
          IdentityWidget(
            title: 'Driver’s license',
            onTap: (){
              settingsViewModel.selectedIdentity = 4;
              showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
                return ImageUploadWidget(onCamera: getImageFromCam,onGallery: getImageFromGallery,);
              }, isScrollControlled: true);
            },
          ),
        ],),
      ),
    );
  }
}

class IdentityWidget extends StatelessWidget {
  const IdentityWidget({
    Key key, this.title = "Permanent Voters Card", this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 29),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.kSecondaryColor
        ),
        child: Row(children: [
          Text(title, style: TextStyle(color: AppColors.kWhite),),
          Spacer(),
          Icon(Icons.navigate_next, color: AppColors.kWhite,)
        ],),
      ),
    );
  }
}
