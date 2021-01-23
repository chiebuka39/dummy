import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/investment/bond_amount_payable_model.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/models/investment/gotten_naira_rate.dart';
import 'package:zimvest/data/models/investment/investment_fixed_fund.dart';
import 'package:zimvest/data/models/investment/investment_fund_model.dart';
import 'package:zimvest/data/models/investment/investment_termed_fund.dart';
import 'package:zimvest/data/models/investment/money_market_fund.dart';
import 'package:zimvest/data/models/investment/mutual_item_detail.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/services/fixed_income_investment_service.dart';
import 'package:zimvest/data/services/investment_service.dart';
import 'package:zimvest/data/view_models/base_model.dart';

import 'package:zimvest/locator.dart';
import 'package:zimvest/screens/tabs/invstment/invest_term.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSInvestmentViewModel extends ChangeNotifier {
  List<InvestmentMutualFund> _mutualFunds;
  List<InvestmentFixedFund> _fixedFunds;
  List<InvestmentTermFund> _termFunds;
  List<InvestmentActivity> _mutualFundsActivity;
  List<InvestmentActivity> _fixedFundsActivity;
  List<InvestmentActivity> _termedFundsActivity;

  List<InvestmentActivity> get mutualFundsActivity => _mutualFundsActivity;
  List<InvestmentActivity> get fixedFundsActivity => _fixedFundsActivity;
  List<InvestmentActivity> get termedFundsActivity => _termedFundsActivity;
  List<InvestmentMutualFund> get mutualFunds => _mutualFunds;
  List<InvestmentFixedFund> get fixedFunds => _fixedFunds;
  List<InvestmentTermFund> get termFunds => _termFunds;

  Map<int, List<ProductTransaction>> _savingsTransactions = Map();
  Map<int, List<ProductTransaction>> get savingsTransactions =>
      _savingsTransactions;

  set mutualFunds(List<InvestmentMutualFund> value);
  set mutualFundsActivity(List<InvestmentActivity> value);
  set fixedFundsActivity(List<InvestmentActivity> value);
  set termedFundsActivity(List<InvestmentActivity> value);
  set fixedFunds(List<InvestmentFixedFund> value);
  set termFunds(List<InvestmentTermFund> value);

  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation(
      {String token});
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation(
      {String token, bool reload});
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation(
      {String token, bool reload});
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities(
      {String token, bool reload});
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities(
      {String token, bool reload});
  Future<Result<List<InvestmentActivity>>> getTermFundActivities(
      {String token, bool reload});
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token});
  Future<Result<List<MutualFund>>> getDollarFund({String token});
  Future<Result<List<TreasuryBill>>> getTreasuryBill({String token});
  Future<Result<List<CommercialPaper>>> getCommercialPaper({String token});
  Future<Result<List<FGNBond>>> getFGNBond({String token});
  Future<Result<List<PromissoryNotes>>> getPromissoryNotes({String token});
  Future<Result<List<EuroBond>>> getEuroBond({String token});
  Future<Result<List<CorporateBond>>> getCorporateBond({String token});
  Future<Result<List<TermInstrument>>> getDollarTermInstruments({String token});
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token});
  Future<Result<Fund>> getFundDetails(
      {String token, String fundName, String fundId});
  Future<Result<dynamic>> buyMoneyMarketFund(
      {String token,
      int productId,
      double amount,
      int fundingChannel,
      int cardId,
      int directDebitFrequency,
      File documentFile});
  Future<Result<Fund>> getFixedFundDetails(
      {String token, String fixedIncomeId, String fixedIncomeName});
  Future<Result<Fund>> getTermFundDetails(
      {String token, String termInstrumentId, String termInstrumentName});
  void reset();
}

class InvestmentViewModel extends ABSInvestmentViewModel {
  ABSInvestmentService _investmentService = locator<ABSInvestmentService>();

  set mutualFunds(List<InvestmentMutualFund> value) {
    _mutualFunds = value;
    notifyListeners();
  }

  set fixedFundsActivity(List<InvestmentActivity> value) {
    _fixedFundsActivity = value;
    notifyListeners();
  }

  set mutualFundsActivity(List<InvestmentActivity> value) {
    _mutualFundsActivity = value;
    notifyListeners();
  }

  set termedFundsActivity(List<InvestmentActivity> value) {
    _termedFundsActivity = value;
    notifyListeners();
  }

  set fixedFunds(List<InvestmentFixedFund> value) {
    _fixedFunds = value;
    notifyListeners();
  }

  set termFunds(List<InvestmentTermFund> value) {
    _termFunds = value;
    notifyListeners();
  }

  @override
  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation(
      {String token, bool reload = false}) async {
    if (reload == true || mutualFunds == null) {
      var result =
          await _investmentService.getMutualFundValuation(token: token);
      if (result.error == false) {
        mutualFunds = result.data;
      }
      print(",,, ${result.data}");
      return result;
    } else {
      return Result<List<InvestmentMutualFund>>(
          data: mutualFunds, error: false, errorMessage: "");
    }
  }

  @override
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities(
      {String token, bool reload}) async {
    if (reload == true || fixedFundsActivity == null) {
      var result =
          await _investmentService.getFixedFundActivities(token: token);
      if (result.error == false) {
        fixedFundsActivity = result.data;
      }
      print(",,, ${result.data}");
      return result;
    } else {
      return Result<List<InvestmentActivity>>(
          data: fixedFundsActivity, error: false, errorMessage: "");
    }
  }

  @override
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation(
      {String token, bool reload}) async {
    if (reload == true || fixedFunds == null) {
      var result = await _investmentService.getFixedFundValuation(token: token);
      if (result.error == false) {
        fixedFunds = result.data;
      }
      print(",,, ${result.data}");
      return result;
    } else {
      return Result<List<InvestmentFixedFund>>(
          data: fixedFunds, error: false, errorMessage: "");
    }
  }

  @override
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities(
      {String token, bool reload}) async {
    if (reload == true || mutualFundsActivity == null) {
      var result =
          await _investmentService.getMutualFundActivities(token: token);
      if (result.error == false) {
        mutualFundsActivity = result.data;
      }
      print(",,, ${result.data}");
      return result;
    } else {
      return Result<List<InvestmentActivity>>(
          data: mutualFundsActivity, error: false, errorMessage: "");
    }
  }

  @override
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation(
      {String token, bool reload}) async {
    if (reload == true || termFunds == null) {
      var result = await _investmentService.getTermFundValuation(token: token);
      if (result.error == false) {
        termFunds = result.data;
      }
      print(",,, ${result.data}");
      return result;
    } else {
      return Result<List<InvestmentTermFund>>(
          data: termFunds, error: false, errorMessage: "");
    }
  }

  @override
  Future<Result<List<InvestmentActivity>>> getTermFundActivities(
      {String token, bool reload}) async {
    if (reload == true || termedFundsActivity == null) {
      var result = await _investmentService.getTermFundActivities(token: token);
      if (result.error == false) {
        termedFundsActivity = result.data;
      }
      print(",,, ${result.data}");
      return result;
    } else {
      return Result<List<InvestmentActivity>>(
          data: termedFundsActivity, error: false, errorMessage: "");
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
  Future<Result<List<MutualFund>>> getMoneyMarketFund(
      {String token, bool reload}) {
    return _investmentService.getMoneyMarketFund(token: token);
  }

  @override
  Future<Result<List<MutualFund>>> getDollarFund({String token}) {
    return _investmentService.getDollarFund(token: token);
  }

  @override
  Future<Result<List<CommercialPaper>>> getCommercialPaper({String token}) {
    // return _investmentService.getCommercialPaper(token: token);
  }

  @override
  Future<Result<List<TreasuryBill>>> getTreasuryBill({String token}) {
    // return _investmentService.getTreasuryBill(token: token);
  }

  @override
  Future<Result<List<EuroBond>>> getEuroBond({String token}) {
    // return _investmentService.getEuroBond(token: token);
  }

  @override
  Future<Result<List<FGNBond>>> getFGNBond({String token}) {
    // return _investmentService.getFGNBond(token: token);
  }

  @override
  Future<Result<List<PromissoryNotes>>> getPromissoryNotes({String token}) {
    // return _investmentService.getPromissoryNotes(token: token);
  }

  @override
  Future<Result<List<CorporateBond>>> getCorporateBond({String token}) {
    // return _investmentService.getCorporateBond(token: token);
  }

  @override
  Future<Result<List<TermInstrument>>> getDollarTermInstruments(
      {String token}) {
    return _investmentService.getDollarTermInstruments(token: token);
  }

  @override
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token}) {
    return _investmentService.getNairaTermInstruments(token: token);
  }

  @override
  Future<Result<Fund>> getFundDetails(
      {String token, String fundName, String fundId}) {
    return _investmentService.getFundDetails(
        token: token, fundId: fundId, fundName: fundName);
  }

  @override
  Future<Result> buyMoneyMarketFund(
      {String token,
      int productId,
      double amount,
      int fundingChannel,
      int cardId,
      int directDebitFrequency,
      File documentFile}) {
    return _investmentService.buyMoneyMarketFund(
        token: token,
        productId: productId,
        amount: amount,
        fundingChannel: fundingChannel,
        directDebitFrequency: directDebitFrequency,
        cardId: cardId,
        documentFile: documentFile);
  }

  @override
  Future<Result<Fund>> getFixedFundDetails(
      {String token, String fixedIncomeId, String fixedIncomeName}) {
    return _investmentService.getFixedFundDetails(
        token: token,
        fixedIncomeId: fixedIncomeId,
        fixedIncomeName: fixedIncomeName);
  }

  @override
  Future<Result<Fund>> getTermFundDetails(
      {String token, String termInstrumentId, String termInstrumentName}) {
    return _investmentService.getTermFundDetails(
        token: token,
        termInstrumentId: termInstrumentId,
        termInstrumentName: termInstrumentName);
  }
}

class InvestmentHighYieldViewModel extends ChangeNotifier {
  ABSInvestmentService _investmentService = locator<ABSInvestmentService>();

  Result<List<TermInstrument>> nairaInstrument = Result<List<TermInstrument>>();
  Result<List<TermInstrument>> dollarInstrument =
      Result<List<TermInstrument>>();
  Result<CommercialPaper> commercialPaper = Result<CommercialPaper>();
  Result<TreasuryBill> treasuryBills = Result<TreasuryBill>();
  Result<CorporateBond> corporateBond = Result<CorporateBond>();
  Result<EuroBond> euroBond = Result<EuroBond>();

  Result<FGNBond> fgnBond = Result<FGNBond>();
  Result<PromissoryNote> promissoryNote = Result<PromissoryNote>();
  ConvertedRate dollarConversion = ConvertedRate();
  Result<GottenRate> gotRate = Result<GottenRate>();
  AmountPayableResponse amountPayableResponse = AmountPayableResponse();



  bool _busy = false;
  bool get busy => _busy;

  bool _status = false;
  bool get status => _status;



  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  Future<void> getNairaTermInstruments() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final naira =
        await _investmentService.getNairaTermInstruments(token: token);
    this.nairaInstrument = naira;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getDollarTermInstruments() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final dollar =
        await _investmentService.getDollarTermInstruments(token: token);
    this.dollarInstrument = dollar;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getNairaTermInstrumentsFilter(num number) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final naira = await _investmentService.getNairaTermInstrumentsFilter(
        token: token, amountFilter: number);
    this.nairaInstrument = naira;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getDollarTermInstrumentsFilter(num number) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final dollar = await _investmentService.getDollarTermInstrumentsFilter(
        token: token, amountFilter: number);
    this.dollarInstrument = dollar;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getCommercialPaper() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final commercialPaper =
        await _investmentService.getCommercialPaper(token: token);
    this.commercialPaper = commercialPaper;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getTreasuryBill() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final treasuryBill = await _investmentService.getTreasuryBill(token: token);
    this.treasuryBills = treasuryBill;
    print(treasuryBill.data.tBillsItems[1].treasureBills.length);
    setBusy(false);
    notifyListeners();
  }

  Future<void> getCorporateBond() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final corporateBond =
        await _investmentService.getCorporateBond(token: token);
    this.corporateBond = corporateBond;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getFGNBond() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final fgnBond = await _investmentService.getFGNBond(token: token);
    this.fgnBond = fgnBond;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getEuroBond() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final euroBond = await _investmentService.getEuroBond(token: token);
    this.euroBond = euroBond;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getPromissoryNote() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    final promissoryNote =
        await _investmentService.getPromissoryNotes(token: token);
    this.promissoryNote = promissoryNote;
    setBusy(false);
    notifyListeners();
  }

  Future<void> buyNairaInstrument(
      {int productId,
      int cardId,
      int fundingChannel,
      String proofOfPayment,
      double amount,
      String uniqueName}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var purchaseRes = await _investmentService.buyNairaInstrument(
      cardId: cardId,
        productId: productId,
        fundingChannel: fundingChannel,
        amount: amount,
        uniqueName: uniqueName,
        token: token);
    print(purchaseRes.toString());
    if (purchaseRes != "Success") {
      _status = false;
      setBusy(false);
    } else {
      _status = true;
      setBusy(false);
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> buyDollarInstrument(
      {int productId,
      int beneficiaryBankType,
      int fundingChannel,
      String proofOfPayment,
      double amount,
      double nairaAmount,
      String uniqueName,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var getAmount =
        await _investmentService.calculateRate(token: token, amount: amount.toInt(), sourceCurrency: "NGN", destiationCurrency: "USD");
    this.dollarConversion = getAmount;
    var purchaseRes = await _investmentService.buyDollarnstrument(
      productId: productId,
      beneficiaryBankType: beneficiaryBankType,
      fundingChannel: fundingChannel,
      amount: getAmount.destinationAmount,
      nairaAmount: getAmount.sourceAmount,
      uniqueName: uniqueName,
      token: token,
    );
    print("Purchase $purchaseRes");
    if (purchaseRes == null) {
      _status = false;
      setBusy(false);
    } else {
      _status = true;
      setBusy(false);
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> getRate() async {
    String token = _localStorage.getUser().token;
    var gotRate = await _investmentService.getRate(token);
    this.gotRate = gotRate;
    notifyListeners();
  }


}

class FixedIncomeViewModel extends BaseViewModel {
  ABSFixedIncomeInvestmentService _investmentService =
      locator<ABSFixedIncomeInvestmentService>();
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  AmountPayableResponse amountPayableResponse = AmountPayableResponse();

  bool _status = false;
  bool get status => _status;

  String _message = "";
  String get message => _message;

  Future<void> buyCommercialPaper(
      {int productId,
      int fundingChannel,
      int intermediaryBankType,
      int instrumentId,
      double amount,
      double rate,
      String uniqueName,
      int instrumentType,
      int cardId,
      bool upFront,
      DateTime maturityDate,
      String instrumentName,
      double investmentAmount}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var amountPayableRes = await _investmentService.calculateAmountPayable(
      token: token,
      instrumentId: instrumentId,
      instrumentType: instrumentType,
      investmentAmount: investmentAmount,
      rate: rate,
      instrumentName: instrumentName,
      maturityDate: maturityDate,
      productId: productId,
      upFront: upFront,
    );
    if (amountPayableRes != null) {
      var buyCommercialPaper = await _investmentService.buyCommercialPaper(
        token: token,
        productId: productId,
        fundingChannel: fundingChannel,
        intermediaryBankType: intermediaryBankType,
        amount: amountPayableRes.investmentAmount,
        rate: rate,
        uniqueName: uniqueName,
        cardId: cardId,
        upFront: amountPayableRes.upFront,
        faceValue: amountPayableRes.faceValue,
        investmentAmount: amountPayableRes.investmentAmount,
      );
      if (buyCommercialPaper != "Success") {
        setBusy(false);
        _message = buyEuroBond.toString();
        _status = false;
      } else {
        setBusy(false);
        // _message = buyEuroBond.toString();
        _status = true;
      }
    }
  }

  Future<void> buyCorporateBond(
      {int productId,
      int fundingChannel,
      int intermediaryBankType,
      int instrumentId,
      double amount,
      double rate,
      String uniqueName,
      int instrumentType,
      bool upFront,
      int cardId,
      DateTime maturityDate,
      String instrumentName,
      double investmentAmount}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var amountPayableRes = await _investmentService.calculateAmountPayable(
      token: token,
      instrumentId: instrumentId,
      instrumentType: instrumentType,
      investmentAmount: investmentAmount,
      rate: rate,
      instrumentName: instrumentName,
      maturityDate: maturityDate,
      productId: productId,
      upFront: upFront,
    );
    if (amountPayableRes != null) {
      var buyCorporateBond = await _investmentService.buyCorporateBond(
        token: token,
        productId: productId,
        fundingChannel: fundingChannel,
        intermediaryBankType: intermediaryBankType,
        amount: this.amountPayableResponse.investmentAmount,
        rate: rate,
        uniqueName: uniqueName,
        cardId: cardId,
        faceValue: this.amountPayableResponse.faceValue,
      );
      if (buyCorporateBond != "Success") {
        setBusy(false);
        _message = buyEuroBond.toString();
        _status = false;
      } else {
        setBusy(false);
        // _message = buyEuroBond.toString();
        _status = true;
      }
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> buyFGNBond(
      {int productId,
      int fundingChannel,
      int intermediaryBankType,
      int instrumentId,
      double amount,
      double rate,
      String uniqueName,
      int instrumentType,
      bool upFront,
      int cardId,
      DateTime maturityDate,
      String instrumentName,
      double investmentAmount}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var amountPayableRes = await _investmentService.calculateAmountPayable(
      token: token,
      instrumentId: instrumentId,
      instrumentType: instrumentType,
      investmentAmount: investmentAmount,
      rate: rate,
      instrumentName: instrumentName,
      maturityDate: maturityDate,
      productId: productId,
      upFront: upFront,
    );
    if (amountPayableRes != null) {
      var buyFGNBond = await _investmentService.buyFGNBond(
        productId: productId,
        token: token,
        cardId: cardId,
        fundingChannel: fundingChannel,
        amount: this.amountPayableResponse.investmentAmount,
        rate: this.amountPayableResponse.rateValue,
        uniqueName: uniqueName,
        faceValue: this.amountPayableResponse.faceValue,
        investmentAmount: this.amountPayableResponse.investmentAmount,
      );
      if (buyFGNBond != "Success") {
        setBusy(false);
        _message = buyFGNBond.toString();
        _status = false;
      } else {
        setBusy(false);
        // _message = buyEuroBond.toString();
        _status = true;
      }
      setBusy(false);
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> buyPromissoryNote(
      {int productId,
      int fundingChannel,
      int intermediaryBankType,
      int instrumentId,
      double amount,
      double rate,
      String uniqueName,
      int instrumentType,
      bool upFront,
      int cardId,
      DateTime maturityDate,
      String instrumentName,
      double investmentAmount}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var amountPayableRes = await _investmentService.calculateAmountPayable(
      token: token,
      instrumentId: instrumentId,
      instrumentType: instrumentType,
      investmentAmount: investmentAmount,
      rate: rate,
      instrumentName: instrumentName,
      maturityDate: maturityDate,
      productId: productId,
      upFront: upFront,
    );
    if (amountPayableRes != null) {
      var buyPromissoryNote = await _investmentService.buyPromissoryNote(
        productId: productId,
        token: token,
        cardId: cardId,
        fundingChannel: fundingChannel,
        amount: amountPayableRes.investmentAmount,
        rate: amountPayableRes.rateValue,
        uniqueName: uniqueName,
        faceValue: amountPayableRes.faceValue,
        investmentAmount: amountPayableRes.investmentAmount,
      );
      if (buyPromissoryNote != "Success") {
        setBusy(false);
        _message = buyPromissoryNote.toString();
        _status = false;
      } else {
        setBusy(false);
        // _message = buyEuroBond.toString();
        _status = true;
      }
      setBusy(false);
    }

    setBusy(false);
    notifyListeners();
  }

  Future<void> buyTreasuryBills(
      {int productId,
      int fundingChannel,
      int intermediaryBankType,
      int instrumentId,
      double amount,
      double rate,
      String uniqueName,
      int instrumentType,
      bool upFront = true,
      int cardId,
      DateTime maturityDate,
      String instrumentName,
      double investmentAmount}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var amountPayableRes = await _investmentService.calculateAmountPayable(
      token: token,
      instrumentId: instrumentId,
      instrumentType: instrumentType,
      investmentAmount: investmentAmount,
      rate: rate,
      instrumentName: instrumentName,
      maturityDate: maturityDate,
      productId: productId,
      upFront: upFront,
    );
    if (amountPayableRes != null) {
      var buyTBill = await _investmentService.buyTreasuryBill(
          cardId: cardId,
          productId: productId,
          token: token,
          fundingChannel: fundingChannel,
          amount: amountPayableRes.investmentAmount,
          rate: amountPayableRes.rateValue,
          uniqueName: uniqueName,
          // cardId: cardId,
          faceValue: amountPayableRes.faceValue,
          investmentAmount: amountPayableRes.investmentAmount,
          upFront: amountPayableRes.upFront);
      print(buyTBill);
      if (buyTBill != "Success") {
        setBusy(false);
        _message = buyTBill.toString();
        _status = false;
      } else {
        setBusy(false);
        // _message = buyTBill.toString();
        _status = true;
      }
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> buyEuroBond(
      {int productId,
      int fundingChannel,
      int intermediaryBankType,
      int instrumentId,
      double amount,
      double rate,
      String uniqueName,
      int instrumentType,
      bool upFront,
      int cardId,
      DateTime maturityDate,
      String instrumentName,
      double investmentAmount}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var amountPayableRes = await _investmentService.calculateAmountPayable(
      token: token,
      instrumentId: instrumentId,
      instrumentType: instrumentType,
      investmentAmount: investmentAmount,
      rate: rate,
      instrumentName: instrumentName,
      maturityDate: maturityDate,
      productId: productId,
      upFront: upFront,
    );
    if (amountPayableRes != null) {
      var buyEuroBond = await _investmentService.buyEuroBond(
        productId: productId,
        cardId: cardId,
        token: token,
        fundingChannel: fundingChannel,
        amount: amountPayableRes.investmentAmount,
        rate: amountPayableRes.rateValue,
        uniqueName: uniqueName,
        faceValue: amountPayableRes.faceValue,
        investmentAmount: amountPayableRes.investmentAmount,
      );
      if (buyEuroBond != "Success") {
        setBusy(false);
        _message = buyEuroBond.toString();
        _status = false;
      } else {
        setBusy(false);
        // _message = buyEuroBond.toString();
        _status = true;
      }
    }
    setBusy(false);
    notifyListeners();
  }
}
