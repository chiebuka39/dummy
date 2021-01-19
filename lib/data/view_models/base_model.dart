import 'package:flutter/material.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/utils/result.dart';
import '../../locator.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  bool _switch = true;
  bool get swittch => _switch;

  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  ABSPaymentService _paymentService = locator<ABSPaymentService>();
  Result<List<Bank>> banks = Result<List<Bank>>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void switcher() {
    _switch = !_switch;
    notifyListeners();
  }

  Future<void> getUserBank() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    this.banks = await _paymentService.getCustomerBank(token);
    setBusy(false);
    notifyListeners();
  }
}
