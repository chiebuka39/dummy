import 'dart:io';

import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:zimvest/screens/account/creat_account_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';

class TextWidget extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final bool error;
  final Color textColor;
  const TextWidget({
    Key key, this.title, this.onChange, this.error = false, this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: 12),
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                border: Border.all(color: error == true? Colors.redAccent : Colors.transparent),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              onChanged: onChange,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.kAccountTextColor),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class TextMultiLineWidget extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final bool error;
  final Color textColor;

  const TextMultiLineWidget({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 145,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: 12),
          ),
          YMargin(8),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              onChanged: onChange,
              maxLines: 4,
              minLines: 1,
              keyboardType: TextInputType.text,
              style: TextStyle(color: AppColors.kAccountTextColor),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class TextWidgetBorder extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final bool error;
  final double bottomMargin;
  final Color textColor;
  final double labelSize;
  const TextWidgetBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white, this.labelSize = 12, this.bottomMargin = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 70+bottomMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: labelSize),
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              onChanged: onChange,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.kAccountTextColor),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14, color: AppColors.kLightText2)),
            ),
          ),
          YMargin(bottomMargin)
        ],),);
  }
}
class AmountWidgetBorder extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final bool error;
  final Color textColor;
  final double labelSize;
  const AmountWidgetBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white, this.labelSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 90,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: labelSize),
          ),
          YMargin(8),
          Container(
            height: 45,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Text("\u20A6"),
                Expanded(
                  child: TextFormField(
                    onChanged: onChange,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: AppColors.kAccountTextColor),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                        hintText: "",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14, color: AppColors.kLightText2)),
                  ),
                ),
              ],
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class DateOfBirthBorderInputWidget extends StatelessWidget {

  final String title;
  final bool error;
  final Color textColor;
  const DateOfBirthBorderInputWidget({
    Key key, this.title,
    this.error = false,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: 12),
          ),
          YMargin(8),
          InkWell(
            onTap: (){
              showDatePicker(context: context, initialDate: DateTime.utc(1994), firstDate: DateTime.utc(1930), lastDate: DateTime.utc(2030)).then((value) {

              });
            },
            child: Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(children: [
                Text("", style: TextStyle(fontSize: 14, color: AppColors.kLightText2),),
                Spacer(),
                SvgPicture.asset("images/bx-calendar2.svg")
              ],),
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class DropdownBorderInputWidget extends StatefulWidget {

  final String title;
  final List<String> items;
  final Color textColor;
  final double bottomMargin;
  final ValueChanged<String> onSelect;


  const DropdownBorderInputWidget({
    Key key, this.title,
    this.textColor = Colors.white, this.items, this.bottomMargin = 20, this.onSelect,
  }) : super(key: key);

  @override
  _DropdownBorderInputWidgetState createState() => _DropdownBorderInputWidgetState();
}

class _DropdownBorderInputWidgetState extends State<DropdownBorderInputWidget> {
  int _checkboxValue;

  String _source;

  @override
  Widget build(BuildContext context) {
    return Container(height: 70+widget.bottomMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: widget.textColor, fontSize: 12),
          ),
          YMargin(8),
          InkWell(
            onTap: (){
              SelectDialog.showModal<String>(
                context,
                label: widget.title,
                titleStyle: TextStyle(color: Colors.brown),
                showSearchBox: false,
                selectedValue: _source,
                backgroundColor: Colors.white,
                items: widget.items,
                onChange: (String selected) {
                    widget.onSelect(selected);
                    setState(() {
                      _source = selected;
                    });
                },
              );
            },
            child: Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color:  AppColors.kLightText),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(children: [
                Text(_source ?? "", style: TextStyle(fontSize: 14, color: AppColors.kPrimaryColor),),
                Spacer(),
                Icon(Icons.keyboard_arrow_down, size: 23,)
              ],),
            ),
          ),
          YMargin(widget.bottomMargin)
        ],),);
  }
}
class EmailWidget extends StatelessWidget {
  final String title;
  final ValueChanged<String> onChange;
  final bool error;
  const EmailWidget({
    Key key, this.title, this.onChange, this.error = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent: Colors.white, fontSize: 12),
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                border: Border.all(color: error == true? Colors.redAccent : Colors.transparent),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.kAccountTextColor),
              onChanged: onChange,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class PasswordWidget extends StatelessWidget {
  final String title;
  const PasswordWidget({
    Key key, this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.kAccountTextColor),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),
          YMargin(5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PasswordValidity(),
                PasswordValidity(isValid: false,),
                PasswordValidity(isValid: false,),
                PasswordValidity(),
              ],
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class LoginPasswordWidget extends StatelessWidget {
  final String title;
  final bool error;
  final ValueChanged<String> onChange;
  const LoginPasswordWidget({
    Key key, this.title, this.error = false, this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent: Colors.white, fontSize: 12),
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                border: Border.all(color: error == true? Colors.redAccent : Colors.transparent),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.kAccountTextColor),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                  hintText: "",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14)),
            ),
          ),

          YMargin(20)
        ],),);
  }
}

class UploadWidget extends StatefulWidget {
  const UploadWidget({
    Key key,
  }) : super(key: key);

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File _file;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [
      _file == null ? Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: AppUtils.getBoxShaddow2
        ),

      ):ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.file(_file, fit: BoxFit.fitWidth,height: 100,width: double.infinity,),
      ),
      YMargin(15),
      InkWell(
        onTap: getImage,
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.kPrimaryColor
          ),
          child: Center(child: Text("Click to upload image",
            style: TextStyle(color: AppColors.kWhite, fontFamily: "Caros-Bold"),),),
        ),
      ),
    ],),);
  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _file = File(pickedFile.path);
    });
  }
}
