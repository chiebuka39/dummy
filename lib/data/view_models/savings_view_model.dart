import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/product_type.dart';
import 'package:zimvest/data/models/saving_plan.dart';

import 'package:zimvest/data/services/savings_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSSavingViewModel extends ChangeNotifier{

  List<SavingPlanModel> _savingPlanModel = [];
  List<SavingPlanModel> get savingPlanModel =>  _savingPlanModel;

  List<List<ProductTransaction>> _savingsTransactions = [];
  List<List<ProductTransaction>> get savingsTransactions =>  _savingsTransactions;

  set savingPlanModel(List<SavingPlanModel> plans);
  set savingsTransactions(List<List<ProductTransaction>> transations);



  Future<Result<List<ProductType>>> getProductTypes({
    String token});
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token});
  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token,
    int productId});
}

class SavingViewModel extends ABSSavingViewModel{
  ABSSavingService _savingService = locator<ABSSavingService>();


  set savingPlanModel(List<SavingPlanModel> plans){
    _savingPlanModel = plans;
    notifyListeners();
  }

  set savingsTransactions(List<List<ProductTransaction>> transactions){
    _savingsTransactions = transactions;
    notifyListeners();
  }

  @override
  Future<Result<List<ProductType>>> getProductTypes({String token})async {
     var result =await _savingService.getProductTypes(token: token);

     print(",,, ${result.data}");
     return result;
  }

  @override
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token})async{
    var result =await _savingService.getSavingPlans(token: token);

    if(result.error == false){
      savingPlanModel = result.data;
    }
    print(",,, ${result.data}");
    return result;
  }

  @override
  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token,
    int productId}) async{
    var result =await _savingService.getTransactionForProductType(token: token,
        productId: productId);
    if(result.error == false){
      _savingsTransactions[productId] = result.data;
    }
    print(",,, ${result.data}");
    return result;
  }

}