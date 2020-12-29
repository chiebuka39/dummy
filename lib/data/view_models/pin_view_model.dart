import 'package:flutter/cupertino.dart';

abstract class ABSPinViewModel  extends ChangeNotifier{
  String _pin1 = "";
  String _pin2 = "";
  String _pin3 = "";
  String _pin4 = "";

  String get pin1 => _pin1;
  String get pin2 => _pin2;
  String get pin3 => _pin3;
  String get pin4 => _pin4;
}