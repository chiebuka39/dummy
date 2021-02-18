import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/wallets/wallets_model.dart';
import 'package:zimvest/data/models/wired_transfer_details_model.dart';
import 'package:zimvest/data/services/investment_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/data/services/wallet_service.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/utils/result.dart';

import '../../locator.dart';

class WalletViewModel extends BaseViewModel {
  ABSWalletService _walletService = locator<ABSWalletService>();
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  List<Wallet> wallets = List<Wallet>();
  List<WalletTransaction> walletTransaction = List<WalletTransaction>();
  ABSPaymentService _paymentService = locator<ABSPaymentService>();
  List<PaymentCard> cards = List<PaymentCard>();
  List<WiredTransferDetails> wiredDetails = List<WiredTransferDetails>();
  Bank get transferBank => _transferBank ;
  Bank _transferBank;
  set transferBank(Bank value){
    _transferBank = value;
    notifyListeners();
  }
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

  Future<Result<void>> fundWallet(
      {num sourceAmount, String currency, int fundingSource}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var getAmount = await _investmentService.calculateRate(
        token: token,
        amount: sourceAmount,
        sourceCurrency: "USD",
        destiationCurrency: "NGN");
    print("opppp ${getAmount.destinationAmount}");
    var fundWallet = await _walletService.fundWallet(
        sourceAmount: getAmount.sourceAmount,
        token: token,
        exchangeAmount: getAmount.destinationAmount,
        currency: currency,
        fundingSource: fundingSource);
    print("p0ioi  ${fundWallet.error}");
    setResult(fundWallet);
    if (fundWallet.error == false) {
      setBusy(false);
      _status = true;
    } else if (fundWallet.error == true) {
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
    return fundWallet;
  }

  Future<Result<void>> fundWalletTransfer(
      {File file, Bank bank}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;

    var fundWallet = await _walletService.fundWalletTransfer(
        bank: bank,
        token: token,
        file: file);
    print("p0ioi  ${fundWallet.error}");
    setResult(fundWallet);
    if (fundWallet.error == false) {
      setBusy(false);
      _status = true;
    } else if (fundWallet.error == true) {
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
    return fundWallet;
  }

  Future<Result<void>> fundWalletWired(
      {num wiredTransferAmount,
      int fundingSource,
      File proofOfPayment,
      int intermediaryBankType}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var wireTransfer = await _walletService.fundWalletWired(
      token: token,
      wiredTransferAmount: wiredTransferAmount,
      fundingSource: fundingSource,
      proofOfPayment: proofOfPayment,
      intermediaryBankType: intermediaryBankType,
    );
    setResult(wireTransfer);
    if (wireTransfer.error == false) {
      setBusy(false);
      _status = true;
    } else if (wireTransfer.error == true) {
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
    return wireTransfer;
  }

  Future<void> getWiredTransferDetails() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var wiredTransferDetails =
        await _walletService.getWiredTransferDetails(token);
    this.wiredDetails = wiredTransferDetails.data;
    setBusy(false);
    notifyListeners();
  }

  Future<void> getTransferDetails() async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var wiredTransferDetails =
    await _walletService.getTransferDetails(token);
    this.transferBank = wiredTransferDetails.data;
    setBusy(false);
    notifyListeners();
  }

  void check() {
    _select = !_select;
    notifyListeners();
  }
}
