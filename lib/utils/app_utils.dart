import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zimvest/utils/strings.dart';

class AppUtils{
  static List<BoxShadow> getBoxShaddow = [
    BoxShadow(
        offset: Offset(0, 1),
        color: Color(0xFF000000).withOpacity(0.05),
        blurRadius: 5)
  ];
  static List<BoxShadow> getBoxShaddow3 = [
    BoxShadow(
        offset: Offset(0, 16),
        color: Color(0xFF000000).withOpacity(0.10),
        blurRadius: 43)
  ];
  static List<BoxShadow> getBoxShaddow2 = [
    BoxShadow(
        offset: Offset(0, 0.05),
        color: Color(0xFF000000).withOpacity(0.03),
        blurRadius: 2)
  ];

  static var states = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "FCT - Abuja",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara"
  ];

  static String getReadableTime(DateTime date) {
    var time = TimeOfDay.fromDateTime(date);

    if (date.hour == 12 || date.hour == 0) {
      var timeString = "12"
          ":${addPreceedingZero(time.minute.toString())}"
          "${time.period == DayPeriod.pm ? ' PM' : ' AM'}";
      return timeString;
    } else {
      var timeString = "${addPreceedingZero(time.hourOfPeriod.toString())}"
          ":${addPreceedingZero(time.minute.toString())}"
          "${time.period == DayPeriod.pm ? ' PM' : ' AM'}";
      return timeString;
    }
  }



  static String addPreceedingZero(String data){
    if(data.length == 1){
      return "0$data";
    }else{
      return data;
    }
  }
  static String getDayString(int value) {
    if (value == 1) {
      return 'Monday';
    }
    if (value == 2) {
      return 'Tuesday';
    }
    if (value == 3) {
      return 'Wednesday';
    }
    if (value == 4) {
      return 'Thurday';
    }
    if (value == 5) {
      return 'Friday';
    }
    if (value == 6) {
      return 'Saturday';
    }
    if (value == 7) {
      return 'Sunday';
    }

    return value.toString();
  }

  static String getDayStringSec(int value) {
    if (value == 1) {
      return 'Mon';
    }
    if (value == 2) {
      return 'Tue';
    }
    if (value == 3) {
      return 'Wed';
    }
    if (value == 4) {
      return 'Thur';
    }
    if (value == 5) {
      return 'Fri';
    }
    if (value == 6) {
      return 'Sat';
    }
    if (value == 7) {
      return 'Sun';
    }

    return value.toString();
  }

  static String addLeadingZeroIfNeeded(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  static String getMonthStringFull(int value) {
    if (value == 1) {
      return 'January';
    }
    if (value == 2) {
      return 'Febuary';
    }
    if (value == 3) {
      return 'March';
    }
    if (value == 4) {
      return 'April';
    }
    if (value == 5) {
      return 'May';
    }
    if (value == 6) {
      return 'June';
    }
    if (value == 7) {
      return 'July';
    }
    if (value == 8) {
      return 'August';
    }
    if (value == 9) {
      return 'September';
    }
    if (value == 10) {
      return 'October';
    }
    if (value == 11) {
      return 'November';
    }
    if (value == 12) {
      return 'December';
    }
    return value.toString();
  }

  static String getMonthStringSemi(int value) {
    if (value == 1) {
      return 'Jan';
    }
    if (value == 2) {
      return 'Feb';
    }
    if (value == 3) {
      return 'Mar';
    }
    if (value == 4) {
      return 'Apr';
    }
    if (value == 5) {
      return 'May';
    }
    if (value == 6) {
      return 'Jun';
    }
    if (value == 7) {
      return 'Jul';
    }
    if (value == 8) {
      return 'Aug';
    }
    if (value == 9) {
      return 'Sep';
    }
    if (value == 10) {
      return 'Oct';
    }
    if (value == 11) {
      return 'Nov';
    }
    if (value == 12) {
      return 'Dec';
    }
    return value.toString();
  }

  static getReadableDate(DateTime time){
    return "${getDayString(time.weekday)}, ${addLeadingZeroIfNeeded(time.day)} ${getMonthStringFull(time.month)}";
  }

  static getReadableDateShort(DateTime time){
    return "${getDayWithSuffix(time.day)} ${getMonthStringFull(time.month)}";
  }

  static String getDayWithSuffix(int time) {
    String timeString = time.toString();
    if(timeString.endsWith("1")){
      return "${time}st";
    }else if(timeString.endsWith("2")){
      return "${time}nd";
    }else if(timeString.endsWith("3")){
      return "${time}rd";
    }else{
      return "${time}th";
    }
  }

  static showError(BuildContext context,{String message = 'Error! The email address or '
      'password is incorrect', String title = 'Login Failed!'}){
    Flushbar(
      borderColor: Color(0xFFF53232),
      backgroundColor: Color(0xFFFBCBCB),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(12),
      borderRadius:14,
      icon: SvgPicture.asset("images/new/fail.svg"),
      flushbarPosition: FlushbarPosition.TOP,
      titleText: Text(title,
        style: TextStyle(fontSize: 11,fontFamily: AppStrings.fontMedium, color: Color(0xFFF53232)),),
      messageText: Text(message,
        style: TextStyle(fontSize: 9,fontFamily: AppStrings.fontNormal,color: Color(0xFFF53232)),),
      duration:  Duration(seconds: 3),
    )..show(context);
  }
}

extension DurationUtils on int {
  Duration seconds() {
    return Duration(seconds: this);
  }

}