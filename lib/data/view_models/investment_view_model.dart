import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/models/investment/investment_fixed_fund.dart';
import 'package:zimvest/data/models/investment/investment_fund_model.dart';
import 'package:zimvest/data/models/investment/investment_termed_fund.dart';
import 'package:zimvest/data/models/investment/money_market_fund.dart';
import 'package:zimvest/data/models/investment/mutual_item_detail.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/product_type.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/savings/savings_frequency.dart';
import 'package:zimvest/data/services/investment_service.dart';

import 'package:zimvest/data/services/savings_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSInvestmentViewModel extends ChangeNotifier{

  List<InvestmentMutualFund> _mutualFunds;
  List<InvestmentFixedFund> _fixedFunds;
  List<InvestmentTermFund> _termFunds;
  List<InvestmentActivity> _mutualFundsActivity;
  List<InvestmentActivity> _fixedFundsActivity;
  List<InvestmentActivity> _termedFundsActivity;



  List<InvestmentActivity> get mutualFundsActivity => _mutualFundsActivity;
  List<InvestmentActivity> get fixedFundsActivity => _fixedFundsActivity;
  List<InvestmentActivity> get termedFundsActivity => _termedFundsActivity;
  List<InvestmentMutualFund> get mutualFunds =>  _mutualFunds;
  List<InvestmentFixedFund> get fixedFunds =>  _fixedFunds;
  List<InvestmentTermFund> get termFunds =>  _termFunds;

  Map<int,List<ProductTransaction>> _savingsTransactions = Map();
  Map<int,List<ProductTransaction>> get savingsTransactions =>  _savingsTransactions;

  set mutualFunds(List<InvestmentMutualFund> value);
  set mutualFundsActivity(List<InvestmentActivity> value);
  set fixedFundsActivity(List<InvestmentActivity> value);
  set termedFundsActivity(List<InvestmentActivity> value);
  set fixedFunds(List<InvestmentFixedFund> value);
  set termFunds(List<InvestmentTermFund> value);




  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation({
    String token});
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation({String token, bool reload});
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation({String token, bool reload});
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities({String token, bool reload});
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities({String token, bool reload});
  Future<Result<List<InvestmentActivity>>> getTermFundActivities({String token, bool reload});
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token});
  Future<Result<List<MutualFund>>> getDollarFund({String token});
  Future<Result<List<TreasuryBill>>> getTreasuryBill({String token});
  Future<Result<List<CommercialPaper>>> getCommercialPaper({String token});
  Future<Result<List<FGNBond>>> getFGNBond({String token});
  Future<Result<List<PromissoryNote>>> getPromissoryNotes({String token});
  Future<Result<List<EuroBond>>> getEuroBond({String token});
  Future<Result<List<CorporateBond>>> getCorporateBond({String token});
  Future<Result<List<TermInstrument>>> getDollarTermInstruments({String token});
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token});
  Future<Result<Fund>> getFundDetails({String token,
    String fundName, String fundId});
  void reset();
}

class InvestmentViewModel extends ABSInvestmentViewModel{
  ABSInvestmentService _investmentService = locator<ABSInvestmentService>();


  set mutualFunds(List<InvestmentMutualFund> value){
    _mutualFunds = value;
    notifyListeners();
  }

  set fixedFundsActivity(List<InvestmentActivity> value){
    _fixedFundsActivity = value;
    notifyListeners();
  }

  set mutualFundsActivity(List<InvestmentActivity> value){
    _mutualFundsActivity = value;
    notifyListeners();
  }

  set termedFundsActivity(List<InvestmentActivity> value){
    _termedFundsActivity = value;
    notifyListeners();
  }

  set fixedFunds(List<InvestmentFixedFund> value){
    _fixedFunds = value;
    notifyListeners();
  }

  set termFunds(List<InvestmentTermFund> value){
    _termFunds = value;
    notifyListeners();
  }



  @override
  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation({String token, bool reload = false})async {
    if(reload == true || mutualFunds == null){
      var result =await _investmentService.getMutualFundValuation(token: token);
      if(result.error == false){
        mutualFunds = result.data;
      }
      print(",,, ${result.data}");
      return result;
    }else{
      return Result<List<InvestmentMutualFund>>(
          data: mutualFunds,error: false,errorMessage: "");
    }


  }

  @override
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities({String token, bool reload}) async{

    if(reload == true || fixedFundsActivity == null){
      var result =await _investmentService.getFixedFundActivities(token: token);
      if(result.error == false){
        fixedFundsActivity = result.data;
      }
      print(",,, ${result.data}");
      return result;
    }else{
      return Result<List<InvestmentActivity>>(
          data: fixedFundsActivity,error: false,errorMessage: "");
    }
  }

  @override
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation({String token, bool reload})async {
    if(reload == true || fixedFunds == null){
      var result =await _investmentService.getFixedFundValuation(token: token);
      if(result.error == false){
        fixedFunds = result.data;
      }
      print(",,, ${result.data}");
      return result;
    }else{
      return Result<List<InvestmentFixedFund>>(
          data: fixedFunds,error: false,errorMessage: "");
    }

  }

  @override
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities({String token, bool reload})async {
    if(reload == true || mutualFundsActivity == null){
      var result =await _investmentService.getMutualFundActivities(token: token);
      if(result.error == false){
        mutualFundsActivity = result.data;
      }
      print(",,, ${result.data}");
      return result;
    }else{
      return Result<List<InvestmentActivity>>(
          data: mutualFundsActivity,error: false,errorMessage: "");
    }


  }

  @override
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation({String token, bool reload})async {
    if(reload == true || termFunds == null){
      var result = await _investmentService.getTermFundValuation(token: token);
      if(result.error == false){
        termFunds = result.data;
      }
      print(",,, ${result.data}");
      return result;
    }else{
      return Result<List<InvestmentTermFund>>(
          data: termFunds,error: false,errorMessage: "");
    }

  }

  @override
  Future<Result<List<InvestmentActivity>>> getTermFundActivities({String token,
    bool reload}) async{
    if(reload == true || termedFundsActivity == null){
      var result = await _investmentService.getTermFundActivities(token: token);
      if(result.error == false){
        termedFundsActivity = result.data;
      }
      print(",,, ${result.data}");
      return result;
    }else{
      return Result<List<InvestmentActivity>>(
          data: termedFundsActivity,error: false,errorMessage: "");
    }
  }

  @override
  void reset() {
    mutualFunds = null;
    mutualFundsActivity = null;
    termedFundsActivity = null;
    termFunds = null;
    fixedFunds = null;
    fixedFundsActivity = null;
  }

  @override
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token, bool reload}) {
    return _investmentService.getMoneyMarketFund(token: token);
  }

  @override
  Future<Result<List<MutualFund>>> getDollarFund({String token}) {
    return _investmentService.getDollarFund(token: token);
  }

  @override
  Future<Result<List<CommercialPaper>>> getCommercialPaper({String token}) {
    return _investmentService.getCommercialPaper(token: token);
  }

  @override
  Future<Result<List<TreasuryBill>>> getTreasuryBill({String token}) {
    return _investmentService.getTreasuryBill(token: token);
  }


  @override
  Future<Result<List<EuroBond>>> getEuroBond({String token}) {
    return _investmentService.getEuroBond(token: token);
  }

  @override
  Future<Result<List<FGNBond>>> getFGNBond({String token}) {
    return _investmentService.getFGNBond(token: token);
  }

  @override
  Future<Result<List<PromissoryNote>>> getPromissoryNotes({String token}) {
    return _investmentService.getPromissoryNotes(token: token);
  }

  @override
  Future<Result<List<CorporateBond>>> getCorporateBond({String token}) {
    return _investmentService.getCorporateBond(token: token);
  }

  @override
  Future<Result<List<TermInstrument>>> getDollarTermInstruments({String token}) {
    return _investmentService.getDollarTermInstruments(token: token);
  }

  @override
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token}) {
    return _investmentService.getNairaTermInstruments(token: token);
  }

  @override
  Future<Result<Fund>> getFundDetails({String token, String fundName, String fundId}) {
    return _investmentService.getFundDetails(token: token,fundId: fundId,fundName: fundName);
  }





}