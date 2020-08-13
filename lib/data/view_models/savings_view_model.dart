import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/product_type.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/savings/aspire_target.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/savings/savings_frequency.dart';

import 'package:zimvest/data/services/savings_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSSavingViewModel extends ChangeNotifier{

  List<SavingPlanModel> _savingPlanModel = [];
  List<ProductType> _productTypes = [];
  List<FundingChannel> _fundingChannels = [];
  List<FundingChannel> get fundingChannels => _fundingChannels;

  List<SavingsFrequency> _savingFrequency = [];
  List<SavingsFrequency> get savingFrequency => _savingFrequency;
  List<ProductType> get productTypes => _productTypes;
  List<SavingPlanModel> get savingPlanModel =>  _savingPlanModel;

  Map<int,List<ProductTransaction>> _savingsTransactions = Map();
  Map<int,List<ProductTransaction>> get savingsTransactions =>  _savingsTransactions;

  set savingPlanModel(List<SavingPlanModel> plans);
  set productTypes(List<ProductType> types);
  set fundingChannels(List<FundingChannel> channels);
  set savingFrequency(List<SavingsFrequency> value);
  set savingsTransactions(Map<int,List<ProductTransaction>> transations);



  Future<Result<List<ProductType>>> getProductTypes({
    String token});
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token});
  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token,
    int productId});
  Future<Result<List<FundingChannel>>> getFundingChannel({String token});
  Future<Result<List<SavingsFrequency>>> getSavingFrequency({String token});
  Future<Result<SavingPlanModel>> createWealthBox({String token,
    int cardId,
    int frequency,
    int fundingChannel,
    double savingsAmount,
    DateTime startDate,
  });
  Future<Result<SavingPlanModel>> createTargetSavings({int cardId,
    int fundingChannel, int frequency, String planName, DateTime maturityDate,
    DateTime startDate, int productId, double targetAmount,
    int savingsAmount, String token});

  Future<Result<void>> topUp({String token,
    int cardId, int custSavingId, int fundingChannel,
    double savingsAmount});
  Future<Result<AspireTarget>> calculateTargetSavings({String token,
    double bulkSum, int frequency,
    DateTime maturityDate, double targetAmount,bool isBulkSum});
}

class SavingViewModel extends ABSSavingViewModel{
  ABSSavingService _savingService = locator<ABSSavingService>();


  set savingPlanModel(List<SavingPlanModel> plans){
    _savingPlanModel = plans;
    notifyListeners();
  }

  set fundingChannels(List<FundingChannel> value){
    _fundingChannels = value;
    notifyListeners();
  }

  set savingFrequency(List<SavingsFrequency> value){
    _savingFrequency = value;
    notifyListeners();
  }

  set savingsTransactions(Map<int,List<ProductTransaction>> transactions){
    _savingsTransactions = transactions;
    notifyListeners();
  }

  @override
  Future<Result<List<ProductType>>> getProductTypes({String token})async {
     var result =await _savingService.getProductTypes(token: token);
      if(result.error == false){
        productTypes = result.data;
      }
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
    print("productId $productId");
    var result =await _savingService.getTransactionForProductType(token: token,
        productId: productId);
    if(result.error == false){
      var t = savingsTransactions;
      t[productId] = result.data ;
      savingsTransactions = t;
    }
    print(",,, ${result.data}");
    return result;
  }

  @override
  set productTypes(List<ProductType> types) {
    _productTypes = types;
    notifyListeners();
  }

  @override
  Future<Result<List<FundingChannel>>> getFundingChannel({String token})async {
    var result =await _savingService.getFundingChannel(token: token);

    if(result.error == false){
      fundingChannels = result.data;
    }
    print(",,, ${result.data}");
    return result;
  }

  @override
  Future<Result<List<SavingsFrequency>>> getSavingFrequency({String token}) async{
    var result =await _savingService.getSavingFrequency(token: token);

    if(result.error == false){
      savingFrequency = result.data;
    }
    print(",,, ${result.data}");
    return result;
  }

  @override
  Future<Result<SavingPlanModel>> createWealthBox({String token, int cardId,
    int frequency, int fundingChannel,
    double savingsAmount, DateTime startDate}) {
    return _savingService.createWealthBox(token: token,
      cardId: cardId,
      frequency: frequency,
      savingsAmount: savingsAmount,
      fundingChannel: fundingChannel,
      startDate: startDate
    );
  }


  @override
  Future<Result<void>> topUp({String token, int cardId,
    int custSavingId, int fundingChannel,
    double savingsAmount}) {
    return _savingService.topUp(token: token,
        cardId: cardId,
        custSavingId: custSavingId,
        savingsAmount: savingsAmount,
        fundingChannel: fundingChannel,
    );
  }

  @override
  Future<Result<AspireTarget>> calculateTargetSavings({String token,
    double bulkSum, int frequency, DateTime maturityDate,
    double targetAmount, bool isBulkSum}) {
    return _savingService.calculateTargetSavings(
      token: token,
      bulkSum: bulkSum,
      frequency: frequency,
      maturityDate: maturityDate,
      targetAmount: targetAmount,
      isBulkSum: isBulkSum
    );
  }

  @override
  Future<Result<SavingPlanModel>> createTargetSavings({int cardId, int fundingChannel,
    int frequency, String planName, DateTime maturityDate,
    DateTime startDate, int productId, double targetAmount,
    int savingsAmount, String token})async {
    var result = await _savingService.createTargetSavings(
        token: token,
        savingsAmount: savingsAmount,
        frequency: frequency,
        maturityDate: maturityDate,
        targetAmount: targetAmount,
        startDate: startDate,
        productId: productId,
        fundingChannel: fundingChannel,
        planName: planName,
        cardId: cardId,
    );
    if(result.data != null){
      var s = savingPlanModel;
      s.add(result.data);
      savingPlanModel = s;
    }
    return result;
  }

}