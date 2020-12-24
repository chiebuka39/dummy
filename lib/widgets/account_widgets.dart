import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:password_criteria/bloc/password_strength/password_strength_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zimvest/animations/select_dialog.dart';
import 'package:zimvest/data/view_models/identity_view_model.dart';
import 'package:zimvest/payment/input_formaters.dart';
import 'package:zimvest/screens/account/creat_account_screen.dart';
import 'package:zimvest/styles/colors.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/margin.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:zimvest/utils/strings.dart';

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
              textCapitalization: TextCapitalization.sentences,
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
  final TextEditingController controller;
  final Color textColor;

  const TextMultiLineWidget({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.black, this.controller,
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
              controller: controller,
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
  final TextEditingController controller;
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
    this.controller,
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
              controller: controller,
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
class TextWidgetDropdownBorder extends StatelessWidget {
  final ValueChanged<String> onChange;
  final String title;
  final TextEditingController controller;
  final bool error;
  final double bottomMargin;
  final Color textColor;
  final double labelSize;
  final TextInputType keyboardType;

  const TextWidgetDropdownBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white,
    this.labelSize = 12, this.bottomMargin = 20,
    this.keyboardType = TextInputType.text,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 80+bottomMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(bottomMargin),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: labelSize),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: error == true? Colors.redAccent : AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
              controller: controller,
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
                    onChanged: (value){
                      String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
                      double _doubleValue = double.parse(_onlyDigits) / 100;
                      onChange(_doubleValue);
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
class AmountWidgetDropdownBorder extends StatelessWidget {
  final ValueChanged<double> onChange;
  final VoidCallback onChangeTitle;
  final String title;
  final bool error;
  final String initialValue;
  final TextEditingController controller;
  final Color textColor;
  final double labelSize;
  const AmountWidgetDropdownBorder({
    Key key, this.title,
    this.onChange,
    this.error = false,
    this.textColor = Colors.white, this.labelSize = 12, this.controller, this.onChangeTitle, this.initialValue,
  }) : super(key: key);

  String _formatNumber(String string) {
    final format = NumberFormat.decimalPattern('en');
    return format.format(int.parse(string));
  }
  @override
  Widget build(BuildContext context) {
    return Container(height: 100,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YMargin(20),
          GestureDetector(
            onTap: onChangeTitle,
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(color:error == true ?Colors.redAccent:  textColor, fontSize: labelSize),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
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
                    initialValue: initialValue,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter(maxDigits: 11)
                    ],
                    onChanged: (value){
                      String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
                      double _doubleValue = double.parse(_onlyDigits) / 100;
                      onChange(_doubleValue);
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
        ],),);
  }
}

class FixedAmountWidgetBorder extends StatelessWidget {
  final String title;

  final String value;
  final Color textColor;
  final double labelSize;
  const FixedAmountWidgetBorder({
    Key key, this.title,
    this.textColor = Colors.white, this.labelSize = 12, this.value,
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
            style: TextStyle(color:textColor, fontSize: labelSize),
          ),
          YMargin(8),
          Container(
            height: 45,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color:  AppColors.kLightText),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Text("\u20A6"),
                Expanded(
                  child: TextFormField(
                    initialValue: value,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyPtBrInputFormatter(maxDigits: 11)
                    ],
                    onChanged: (value){
                      String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
                      double _doubleValue = double.parse(_onlyDigits) / 100;

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
  final DateTime startDate;
  final DateTime initialDate;
  final DateTime selected;
  final DateTime endDate;
  const DateOfBirthBorderInputWidget({
    Key key, this.title,
    this.error = false,
    this.textColor = Colors.white,
    this.setDate,
    @required this.startDate,
  @required this.initialDate,
  @required this.endDate, this.selected,
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
              showDatePicker(context: context, initialDate: initialDate,
                  firstDate: startDate, lastDate: endDate).then((value) {
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
                Text(selected == null?"":AppUtils.getReadableDateShort(selected), style: TextStyle(fontSize: 14, color: AppColors.kAccountTextColor),),
                Spacer(),
                SvgPicture.asset("images/bx-calendar2.svg")
              ],),
            ),
          ),
          YMargin(20)
        ],),);
  }
}
class DropdownBorderInputWidget extends StatelessWidget {

  final String title;
  final String source;
  final List<String> items;
  final Color textColor;
  final double bottomMargin;
  final ValueChanged<String> onSelect;
  final double labelSize;


  const DropdownBorderInputWidget({
    Key key, this.title,

    this.textColor = Colors.white,this.labelSize = 12, this.items, this.bottomMargin = 20, this.onSelect, this.source,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(height: 105+bottomMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontSize: labelSize,fontFamily: AppStrings.fontMedium),
          ),
          YMargin(20),
          InkWell(
            onTap: (){
              SelectDialog.showModal<String>(
                context,
                label: title,
                constraints: BoxConstraints(
                  maxHeight: 350,
                  maxWidth: MediaQuery.of(context).size.width * 0.7
                ),
                titleStyle: TextStyle(color: Colors.brown),
                showSearchBox: false,
                selectedValue: source,
                backgroundColor: Colors.white,
                items: items,
                onChange: (String selected) {
                    onSelect(selected);
                },
              );
            },
            child: Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColors.kGreyBg,
                  border: Border.all(color:  AppColors.kLightText),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Text(source ?? "Select Bank", style: TextStyle(fontSize: 12, color: AppColors.kTextColor),),
                Spacer(),
                Icon(Icons.keyboard_arrow_down, size: 23,)
              ],),
            ),
          ),
          YMargin(bottomMargin)
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
              initialValue: "testex.testex@mailinator.com",
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
  bool islowerCase = false;
  bool isValidPassword = false;
  bool isuperCase = false;
  bool isnumber = false;
  bool isEightChar = false;
  bool isspecialChar = false;
  bool ispattern = false;
  String isVisible;
  PasswordStrengthBloc passwordStrengthBloc = PasswordStrengthBloc();

  bool obscure = true;
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
          islowerCase = true;
          isuperCase = true;
          isnumber = true;
          isEightChar = true;
          isspecialChar = true;
          ispattern = true;
          isValidPassword = true;
          print("kkkkkk");
        }
        if (state is InvalidPassword) {
          isValidPassword = false;
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
          //
        }
        //widget.onChange(password,isValidPassword);
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          obscureText: obscure,
                          keyboardType: TextInputType.text,
                          onChanged: (value){

                            setState(() {
                              password = value;
                            });

                            widget.onChange(password,false);
                          },
                          style: TextStyle(color: AppColors.kAccountTextColor),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                              hintText: "",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 14)),
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          child: Icon(obscure == true ? Icons.visibility: Icons.visibility_off,size: 17,
                            color: AppColors.kAccountTextColor,)),
                      XMargin(10)
                    ],
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
class LoginPasswordWidget extends StatefulWidget {
  final String title;
  final bool error;
  final ValueChanged<String> onChange;
  const LoginPasswordWidget({
    Key key, this.title, this.error = false, this.onChange,
  }) : super(key: key);

  @override
  _LoginPasswordWidgetState createState() => _LoginPasswordWidgetState();
}

class _LoginPasswordWidgetState extends State<LoginPasswordWidget> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(height: 115,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color:widget.error == true ?Colors.redAccent: Colors.white, fontSize: 12),
          ),
          YMargin(8),
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: AppColors.kLightText,
                border: Border.all(color: widget.error == true? Colors.redAccent : Colors.transparent),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: "Password@1",
                    obscureText: obscure,
                    onChanged: widget.onChange,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: AppColors.kAccountTextColor),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                        hintText: "",
                        border: InputBorder.none,

                        hintStyle: TextStyle(fontSize: 14)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                    child: Icon(obscure == true ? Icons.visibility: Icons.visibility_off,size: 17,
                      color: AppColors.kAccountTextColor,)),
                XMargin(10)
              ],
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
  final ValueChanged<File> onSave;
  final String title;
  const UploadWidget({
    Key key, this.onSave, this.title,
  }) : super(key: key);

  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File _file;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(widget.title,
        style: TextStyle(fontSize: 10,color: AppColors.kAccountTextColor),),
      YMargin(10),
      _file == null ? GestureDetector(
        onTap: getImage,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: AppUtils.getBoxShaddow2
          ),
          child: Center(child: Text("Click to choose an image", style: TextStyle(fontSize: 12),),),

        ),
      ):ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.file(_file, fit: BoxFit.fitWidth,height: 100,width: double.infinity,),
      ),
      YMargin(15),
      InkWell(
        onTap: (){
          if(_file != null){
            widget.onSave(_file);
          }
        },
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _file = File(pickedFile.path);
    });
  }
}


class FixedDateOfBirthBorderInputWidget extends StatefulWidget {

  final String title;
  final bool error;
  final ValueChanged<DateTime> setDate;
  final Color textColor;
  final DateTime startDate;
  final DateTime initialDate;
  final DateTime endDate;
  const FixedDateOfBirthBorderInputWidget({
    Key key, this.title,
    this.error = false,
    this.textColor = Colors.white,
    this.setDate,
    @required this.startDate,
    @required this.initialDate,
    @required this.endDate,
  }) : super(key: key);

  @override
  _FixedDateOfBirthBorderInputWidgetState createState() => _FixedDateOfBirthBorderInputWidgetState();
}

class _FixedDateOfBirthBorderInputWidgetState extends State<FixedDateOfBirthBorderInputWidget> {
  DateTime time;
  @override
  Widget build(BuildContext context) {
    return Container(height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color:widget.error == true ?Colors.redAccent:  widget.textColor, fontSize: 12),
          ),
          YMargin(8),
          InkWell(
            onTap: (){
              showDatePicker(context: context, initialDate: widget.initialDate, firstDate: widget.startDate, lastDate: widget.endDate).then((value) {
                widget.setDate(value);
                setState(() {
                  time = value;
                });
              });
            },
            child: Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: widget.error == true? Colors.redAccent : AppColors.kLightText),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(children: [
                Text(time == null?"":AppUtils.getReadableDateShort(time), style: TextStyle(fontSize: 14, color: AppColors.kAccountTextColor),),
                Spacer(),
                SvgPicture.asset("images/bx-calendar2.svg")
              ],),
            ),
          ),
          YMargin(20)
        ],),);
  }
}
