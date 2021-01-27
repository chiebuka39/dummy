import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/investment/investment_transactions.dart';
import 'package:zimvest/data/models/transactions_portfolio/dollar_model.dart';
import 'package:zimvest/data/models/transactions_portfolio/investment_activities.dart';
import 'package:zimvest/data/models/transactions_portfolio/naira_model.dart';
import 'package:zimvest/data/services/transaction_services.dart';
import 'package:zimvest/data/view_models/base_model.dart';

import '../../locator.dart';

class PortfolioViewModel extends BaseViewModel {
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  List<DollarPortfolioTransactions> dollarTransaction =
      List<DollarPortfolioTransactions>();
  List<NairaPortfolioTransactions> nairaTransaction =
      List<NairaPortfolioTransactions>();
  final ABSTransactionService _transactionService =
      locator<ABSTransactionService>();
  Activities activities = Activities();
  List<InvestmentTransactions> transactions = List<InvestmentTransactions>();

  Future<void> getNairaPortfolio() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var res = await _transactionService.getNairaTransactions(token);
    this.nairaTransaction = res;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getDollarPortfolio() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var res = await _transactionService.getDollarTransactions(token);
    this.dollarTransaction = res;

    print(res.length);
    setBusy(false);
    notifyListeners();
  }

  Future<void> getInvestmentActivities(
      {String name, int transactionId, int instrumentId}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var res = await _transactionService.getInvestmentActivities(
        token: token,
        name: name,
        transactionId: transactionId,
        instrumentId: instrumentId);
    this.activities = res;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getFixedInvestmentActivities(
      {String name, int transactionId, int instrumentId}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var res = await _transactionService.getFixedInvestmentActivities(
        token: token,
        name: name,
        transactionId: transactionId,
        instrumentId: instrumentId);
    this.activities = res;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getInvestmentTransactions(int transactionType)async{
    setBusy(true);
    String token = _localStorage.getUser().token;
    var res = await _transactionService.getInvestmentTransactions(transactionType: transactionType, token: token);
    print(res);
    this.transactions = res;
    setBusy(false);
    notifyListeners();
  }
}
