import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:password_criteria/bloc/password_strength/password_strength_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimvest/animations/select_dialog.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/screens/account/creat_account_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class TextWidget extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final bool error;
  final TextInputType textInputType;
  final Color textColor;
  const TextWidget({
    Key key, this.title, this.onChange, this.error = false,
    this.textColor = Colors.white,this.textInputType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("this is erro $error");
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
              keyboardType: textInputType,
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
  final TextInputType keyboardType;
  const TextWidgetBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white,
    this.labelSize = 12, this.bottomMargin = 20,
    this.keyboardType = TextInputType.text,
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
              keyboardType: keyboardType,
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
class CardWidgetBorder extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final bool error;
  final double bottomMargin;
  final Color textColor;
  final double labelSize;
  final TextInputType keyboardType;

  final List<TextInputFormatter> inputFormaters;
  const CardWidgetBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white,
    this.labelSize = 12, this.bottomMargin = 20,
    this.keyboardType = TextInputType.text, this.inputFormaters,
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
              keyboardType: keyboardType,
              inputFormatters: inputFormaters,
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
class UploadWidgetBorder extends StatelessWidget {
  final ValueChanged<File> onChange;
  final String title;
  final String desc;
  final bool error;
  final double bottomMargin;
  final Color textColor;
  final double labelSize;
  const UploadWidgetBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white, this.labelSize = 12, this.bottomMargin = 20, this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70+bottomMargin,
      width: double.infinity,
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
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(desc,
                  style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 14),),
              ),
            ),
          ),
          YMargin(bottomMargin)
        ],),);
  }
}
class AmountWidgetBorder extends StatelessWidget {
  final ValueChanged<double> onChange;
  final String title;
  final bool error;
  final TextEditingController controller;
  final Color textColor;
  final double labelSize;
  const AmountWidgetBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white, this.labelSize = 12, this.controller,
  }) : super(key: key);

  String _formatNumber(String string) {
    final format = NumberFormat.decimalPattern('en');
    return format.format(int.parse(string));
  }
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
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter(maxDigits: 11)
                    ],
                    onChanged: (string){
                      onChange(double.parse(string));
                    },
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
  final ValueChanged<DateTime> setDate;
  final Color textColor;
  const DateOfBirthBorderInputWidget({
    Key key, this.title,
    this.error = false,
    this.textColor = Colors.white, this.setDate,
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
                setDate(value);
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
  final double labelSize;


  const DropdownBorderInputWidget({
    Key key, this.title,

    this.textColor = Colors.white,this.labelSize = 12, this.items, this.bottomMargin = 20, this.onSelect,
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
            style: TextStyle(color: widget.textColor, fontSize: widget.labelSize),
          ),
          YMargin(8),
          InkWell(
            onTap: (){
              SelectDialog.showModal<String>(
                context,
                label: widget.title,
                constraints: BoxConstraints(
                  maxHeight: 300,
                  maxWidth: MediaQuery.of(context).size.width * 0.7
                ),
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
class PasswordWidget extends StatefulWidget {
  final String title;
  final Function onChange;
  const PasswordWidget({
    Key key, this.title, this.onChange,
  }) : super(key: key);

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  String password = "";
  bool isValidPassword = false;
  bool islowerCase = false;
  bool isuperCase = false;
  bool isnumber = false;
  bool isEightChar = false;
  bool isspecialChar = false;
  bool ispattern = false;
  String isVisible;
  PasswordStrengthBloc passwordStrengthBloc = PasswordStrengthBloc();
  @override
  Widget build(BuildContext context) {
    passwordStrengthBloc.add(OnTextChangedEvent(text: password));
    return BlocListener<PasswordStrengthBloc,PasswordStrengthState>(
      listener: (context,state){
        if (state is OnTextChangedState) {
          isVisible = state.text;
          passwordStrengthBloc.add(PasswordRegEx(passwordtext: state.text));
        }
        if (state is ValidPassword) {
          isValidPassword = true;
          islowerCase = true;
          isuperCase = true;
          isnumber = true;
          isEightChar = true;
          isspecialChar = true;
          ispattern = true;
        }
        if (state is InvalidPassword) {
          isValidPassword = state.isInvalidPassword;
          if (state.passwordValidation['lowerCase'] != null &&
              state.passwordValidation['lowerCase']) {
            islowerCase = true;
          } else {
            islowerCase = false;
          }
          if (state.passwordValidation['upperCase'] != null &&
              state.passwordValidation['upperCase']) {
            isuperCase = true;
          } else {
            isuperCase = false;
          }
          if (state.passwordValidation['specialChar'] != null &&
              state.passwordValidation['specialChar']) {
            isspecialChar = true;
          } else {
            isspecialChar = false;
          }
          if (state.passwordValidation['minEightChar'] != null &&
              state.passwordValidation['minEightChar']) {
            isEightChar = true;
          } else {
            isEightChar = false;
          }
          if (state.passwordValidation['oneNumber'] != null &&
              state.passwordValidation['oneNumber']) {
            isnumber = true;
          } else {
            isnumber = false;
          }
        }
      },
      bloc:passwordStrengthBloc,
      child:BlocBuilder<PasswordStrengthBloc, PasswordStrengthState>(
        builder:(context, state){
          return Container(height: 115,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                YMargin(8),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: AppColors.kLightText,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      setState(() {
                        password = value;
                      });
                      widget.onChange(password,isValidPassword);
                    },
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
                      PasswordValidity(isValid: isEightChar,),
                      PasswordValidity(isValid: isuperCase,value: "Uppercase",),
                      PasswordValidity(isValid: islowerCase,value: "Lowercase",),
                      PasswordValidity(value: "Symbol",isValid: isspecialChar,),
                    ],
                  ),
                ),
                YMargin(20)
              ],),);
        },
        bloc:passwordStrengthBloc,
      )
    );
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
class LoginPasswordOutlineWidget extends StatelessWidget {
  final String title;
  final bool error;
  final Color titleColor;
  final ValueChanged<String> onChange;
  const LoginPasswordOutlineWidget({
    Key key, this.title, this.error = false, this.onChange, this.titleColor =Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color:error == true ?Colors.redAccent: titleColor, fontSize: 12),
          ),
          YMargin(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Expanded(
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
                SvgPicture.asset("images/visible.svg",)
              ],
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
