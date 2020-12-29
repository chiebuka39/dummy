import 'package:flutter/cupertino.dart';

abstract class ABSPinViewModel  extends ChangeNotifier{
  String _pin1 = "";
  String _pin2 = "";
  String _pin3 = "";
  String _pin4 = "";
  String _amount = "";

  String get pin1 => _pin1;
  String get pin2 => _pin2;
  String get pin3 => _pin3;
  String get pin4 => _pin4;
  String get amount => _amount;

  set pin1(String value);
  set pin2(String value);
  set pin3(String value);
  set pin4(String value);
  set amount(String value);

  void resetPins();
  void resetAmount();
}

class PinViewModel extends ABSPinViewModel{
  @override
  set pin1(String value) {
    _pin1 = value;
    notifyListeners();
  }

  @override
  set pin2(String value) {
    _pin2 = value;
    notifyListeners();
  }

  @override
  set pin3(String value) {
    _pin3 = value;
    notifyListeners();
  }

  @override
  set pin4(String value) {
    _pin4 = value;
    notifyListeners();
  }

  @override
  void resetPins() {
    pin1 = '';
    pin2 = '';
    pin3 = '';
    pin4 = '';
  }

  @override
  set amount(String value) {
    _amount = value;
    notifyListeners();
  }

  @override
  void resetAmount() {
    _amount = "";
    notifyListeners();
  }

}