import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/data/view_models/settings_view_model.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class PreviewScreen extends StatefulWidget {
  final File image;

  const PreviewScreen({Key key, this.image}) : super(key: key);
  static Route<dynamic> route(File image) {
    return MaterialPageRoute(
        builder: (_) => PreviewScreen(image: image,),
        settings:
        RouteSettings(name: PreviewScreen().toStringShort()));
  }
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  ABSSettingsViewModel settingsViewModel;
  ABSIdentityViewModel identityViewModel;

  File image;


  bool loading = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    if(widget.image != null){
      image = widget.image;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingsViewModel = Provider.of(context);
    identityViewModel = Provider.of(context);
    return Scaffold(
      appBar: ZimAppBar(
        text: "Preview",
        callback: (){
          Navigator.pop(context);
        },
        icon: Icons.arrow_back_ios,
      ),
      body: Column(children: [
        Expanded(
          flex: 4,
          child: Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.fill
                ),
              )
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(

            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.kWhite
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              YMargin(20),
              Text("Make sure your details are clear and readable", style: TextStyle(fontSize: 13,
                  fontFamily: AppStrings.fontNormal),),
                YMargin(30),
                PrimaryButtonNew(
                  title: "Upload Photo",
                  loading:  loading,
                  onTap: () async{
                    print("lll ${settingsViewModel.selectedIdentity}");
                    if(settingsViewModel.selectedIdentity == null){
                      print("pPPPPPPPPPPPPPPP");
                      await uploadUtility(context);
                    }else{
                      print("oooooooooooooo");
                      await uploadIdentity(context);
                    }

                  },
                ),
                YMargin(20),
                FlatButton(
                  child: Text("Upload Another",
                    style: TextStyle(fontSize: 13,
                        fontFamily: AppStrings.fontMedium),),
                  onPressed: getImage,

                ),

            ],),
          ),
        )
      ],),
    );
  }

  Future uploadUtility(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var result = await settingsViewModel.uploadUtilityBill(
      token: identityViewModel.user.token,
      file: image
    );
    setState(() {
      loading = false;
    });
    if(result.error == false){
      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
        return PasswordSuccessWidget(onDone: (){
          Navigator.pop(context);
          Navigator.pop(context);
        },message: "Your Upload was successfully",);
      });
    }else{
      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
        return PasswordSuccessWidget(
          success: false,
          onDone: (){
    
          Navigator.pop(context);
        },message: result.errorMessage == null ? "We could not upload your document": result.errorMessage,);
      });
    }
  }
  Future uploadIdentity(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var result = await settingsViewModel.uploadIdentification(
      token: identityViewModel.user.token,
      file: image,
      id: "ppp",
    );
    setState(() {
      loading = false;
    });
    if(result.error == false){
      settingsViewModel.selectedIdentity = null;
      showModalBottomSheet < Null > (context: context, builder: (BuildContext context) {
        return PasswordSuccessWidget(onDone: (){
          Navigator.pop(context);
          Navigator.pop(context);
        },message: "Your Upload was successfully",);
      });
    }else{

      showModalBottomSheet < Null > (context: context,
        builder: (BuildContext context) {
        return PasswordSuccessWidget(

          onDone: (){

          Navigator.pop(context);
        },success:false,
          message: result.errorMessage == null ? "We could not upload your document": result.errorMessage,);
      },isDismissible: false);
    }
  }
}
