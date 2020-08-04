import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSPaymentViewModel extends ChangeNotifier{

  List<Bank> _userBanks = [];
  List<Bank> get userBanks => _userBanks;

  set userBanks(List<Bank> value);

  Future<Result<List<Bank>>> getBanks(String token);
  Future<Result<List<String>>> validateBank({String token, int customerId,
    String accountNum, String bankCode});
  Future<Result<List<Bank>>> getCustomerBank(String token);
  Future<Result<Bank>> addBank(
      {String token,
        int bankId,
        String bankName,
        String accountName,
        String accountNum});
  Future<Result<void>> deleteBank(String token, int bankId);
}

class PaymentViewModel extends ABSPaymentViewModel{
  ABSPaymentService _paymentService = locator<ABSPaymentService>();

  set userBanks(List<Bank> value){
    _userBanks = value;
    notifyListeners();
  }


  @override
  Future<Result<List<Bank>>> getBanks(String token)async {
     var result =await _paymentService.getBanks(token);

     //print(",,, ${result.data}");
     return result;
  }

  @override
  Future<Result<List<String>>> validateBank({String token, int customerId,
    String accountNum, String bankCode}) {
    return _paymentService.validateBank(token: token,customerId: customerId,
        accountNum: accountNum,bankCode: bankCode);
  }

  @override
  Future<Result<Bank>> addBank({String token, int bankId, String bankName,
    String accountName, String accountNum}) async{

    var result = await _paymentService.addBank(token: token,bankName: bankName,
        accountNum: accountNum,bankId: bankId, accountName: accountName);

    if(result.error == false){
      List<Bank> banks = userBanks;
      banks.add(result.data);
      userBanks = banks;
    }
    return result;
  }

  @override
  Future<Result<List<Bank>>> getCustomerBank(String token)async {
    var result = await _paymentService.getCustomerBank(token);
    if(result.error == false){
      userBanks = result.data;
    }
    return result;
  }

  @override
  Future<Result<void>> deleteBank(String token, int bankId)async {
    var result =  await _paymentService.deleteBank(token,bankId);

    if(result.error == false){
      List<Bank> banks = userBanks;
      banks.removeWhere((element) => element.id == bankId);
      userBanks = banks;
    }
    return result;
  }

}