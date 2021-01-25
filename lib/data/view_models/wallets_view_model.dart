import 'package:flutter/material.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/wallets/wallets_model.dart';
import 'package:zimvest/data/services/investment_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/data/services/wallet_service.dart';
import 'package:zimvest/data/view_models/base_model.dart';

import '../../locator.dart';

class WalletViewModel extends BaseViewModel {
  ABSWalletService _walletService = locator<ABSWalletService>();
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  List<Wallet> wallets = List<Wallet>();
  List<WalletTransaction> walletTransaction = List<WalletTransaction>();
  ABSPaymentService _paymentService = locator<ABSPaymentService>();
  List<PaymentCard> cards = List<PaymentCard>();
   ABSInvestmentService _investmentService = locator<ABSInvestmentService>();
   
  bool _status = false;
  bool get status => _status;

  String _message = "";
  String get message => _message;

  bool _select = false;
  bool get select => _select;

  // TermInstrument _nairaInstrument;
  // TermInstrument get pickednairaInstrument => _nairaInstrument;
  PageController controller = PageController();

  Future<void> getWallets() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var wallets = await _walletService.getWallets(token);
    this.wallets = wallets;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getWalletTransactions() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var walletTransactions = await _walletService.getWalletsTransactions(token);
    this.walletTransaction = walletTransactions;

    setBusy(false);
    notifyListeners();
  }

  Future<void> getCards() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var cards = await _paymentService.getUserCards(token);
    this.cards = cards.data;
    setBusy(false);
    notifyListeners();
  }

  Future<void> fundWallet({num sourceAmount, String currency,
      int fundingSource}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
        var getAmount =
        await _investmentService.calculateRate(token: token, amount: sourceAmount, sourceCurrency: "USD", destiationCurrency: "NGN");
        // print(getAmount.destinationAmount);
    var fundWallet = await _walletService.fundWallet(
        sourceAmount: getAmount.sourceAmount,
        token: token,
        exchangeAmount: getAmount.destinationAmount,
        currency: currency,
        fundingSource: 1);
    print(fundWallet);
    if (fundWallet == "Operation Successful") {
      setBusy(false);
      _status = true;
    } else if (fundWallet == null) {
      setBusy(false);
      _message = "Oops! Something went wrong try again later";
      _status = false;
    } else {
      setBusy(false);
      _message = fundWallet.toString();
      _status = false;
    }
    setBusy(false);
    notifyListeners();
  }

  void check() {
    _select = !_select;
    notifyListeners();
  }
}
