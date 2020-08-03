import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSPaymentViewModel extends ChangeNotifier{


  Future<Result<List<Bank>>> getBanks(String token);
  Future<Result<List<String>>> validateBank({String token, int customerId,
    String accountNum, String bankCode});
}

class PaymentViewModel extends ABSPaymentViewModel{
  ABSPaymentService _paymentService = locator<ABSPaymentService>();




  @override
  Future<Result<List<Bank>>> getBanks(String token)async {
     var result =await _paymentService.getBanks(token);

     print(",,, ${result.data}");
     return result;
  }

  @override
  Future<Result<List<String>>> validateBank({String token, int customerId,
    String accountNum, String bankCode}) {
    return _paymentService.validateBank(token: token,customerId: customerId,
        accountNum: accountNum,bankCode: bankCode);
  }

}