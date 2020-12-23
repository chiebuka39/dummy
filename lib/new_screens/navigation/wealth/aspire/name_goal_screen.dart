import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimvest/new_screens/navigation/wealth/aspire/save_target_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/margin.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/widgets/buttons.dart';

class NameYourGoalScreen extends StatefulWidget {
  final String goalName;

  const NameYourGoalScreen({Key key, this.goalName =""}) : super(key: key);
  static Route<dynamic> route({String goalName}) {
    return MaterialPageRoute(
        builder: (_) => NameYourGoalScreen(goalName: goalName,),
        settings:
        RouteSettings(name: NameYourGoalScreen().toStringShort()));
  }
  @override
  _NameYourGoalScreenState createState() => _NameYourGoalScreenState();
}

class _NameYourGoalScreenState extends State<NameYourGoalScreen> {

  File _image;
  String goalName;
  final picker = ImagePicker();

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
  void initState() {
    goalName = widget.goalName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kPrimaryColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,size: 20,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text("Create Zimvest Aspire",
          style: TextStyle(color: Colors.black87,fontSize: 14),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          YMargin(20),
          GestureDetector(
            onTap: getImage,
            child: Container(
              height: 154,
              width: (width /2) - 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _image == null ? CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/tick-bc0e3.appspot.com/o/pexels-anete-lusina-5723322.'
                        'jpg?alt=media&token=4858ef91-820b-4ff3-aae7-a02ce3507c6d',
                      height: 154,fit: BoxFit.fill,):Image.file(_image,height: 154,fit: BoxFit.fill),
                  ),
                  Container(
                    height: 154,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.4)
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        shape: BoxShape.circle
                      ),
                      child: Center(child: SvgPicture.asset('images/cam.svg'),),
                    ),
                  ),



                ],
              ),
            ),
          ),
          YMargin(57),
          Text("Name Your goal", style: TextStyle(fontSize: 15, fontFamily: AppStrings.fontBold),),
            YMargin(35),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: AppColors.kGreyBg,
                borderRadius: BorderRadius.circular(12)
              ),
              child: TextFormField(
                initialValue: goalName,
                onChanged: (value){
                  setState(() {
                    goalName = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
              ),
            ),
            YMargin(35),
            RoundedNextButton(
              onTap: goalName.length >1 ?  (){
                Navigator.push(context, SavingsTargetScreen.route());
              }:null,
            )
        ],),
      ),
    );
  }
}
