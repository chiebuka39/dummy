import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/payment/card_payload.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/app_utils.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSPaymentViewModel extends ChangeNotifier {
  PaymentCard _selectedCard;
  Bank _selectedBank;
  PaymentCard get selectedCard => _selectedCard;
  Bank get selectedBank => _selectedBank;
  List<Bank> _userBanks;
  List<WalletTransaction> _walletTransactions = [];
  List<PaymentCard> _userCards = [];
  List<Bank> get userBanks => _userBanks;
  List<PaymentCard> get userCards => _userCards;
  String _investmentName;
  String get investmentName => _investmentName;
  double _withdrawableAmount;
  double get withdrawableAmount => _withdrawableAmount;
  int _transactionId;
  int get transactionId => _transactionId;
  int _instrumentId;
  int get instrumentId => _instrumentId;
  int _amountAvailable;
  int get amountAvailable => _amountAvailable;
  double _investmentAmount;
  double get investmentAmount => _investmentAmount;
  TextEditingController amountController = TextEditingController();

  TermInstrument _nairaInstrument;
  TermInstrument get pickednairaInstrument => _nairaInstrument;
  TermInstrument _dollarInstrument;
  TermInstrument get pickeddollarInstrument => _dollarInstrument;

  List<Wallet> _wallet;
  List<Wallet> get wallet => _wallet;
  List<WalletTransaction> get walletTransaction => _walletTransactions;

  set userBanks(List<Bank> value);
  set walletTransaction(List<WalletTransaction> value);
  set wallet(List<Wallet> value);
  set selectedCard(PaymentCard value);
  set selectedBank(Bank value);
  set userCards(List<PaymentCard> value);
  set investmentName(String value);
  set withdrawableAmount(double value);
  set transactionId(int value);
  set instrumentId(int value);
  set availableAmount(int value);
  set pickNairaInstrument(TermInstrument value);
  set pickDollarInstrument(TermInstrument value);
  set investmentAmount(double amount);

  Future<Result<List<Bank>>> getBanks(String token);
  Future<Result<List<String>>> validateBank(
      {String token, int customerId, String accountNum, String bankCode});
  Future<Result<List<Bank>>> getCustomerBank(String token);
  Future<Result<List<PaymentCard>>> getUserCards(String token);
  Future<Result<List<Wallet>>> getWallet(String token);
  Future<Result<List<WalletTransaction>>> getWalletTransactions(String token);
  Future<Result<Bank>> addBank(
      {String token,
      int bankId,
      String bankName,
      String accountName,
      String accountNum});
  Future<Result<void>> deleteBank(String token, int bankId);
  Future<Result<void>> deleteCard(String token, int cardId);
  Future<Result<Bank>> addCard(
      {String token,
      String cardNumber,
      String expiryDate,
      String cvv,
      String pin});
  Future<Result<CardPayload>> registerNewCard(String token);
  Future<Result<void>> paymentConfirmation(String token, String trnasactionRef);
  void onKeyboardTap(String value);
}

class PaymentViewModel extends ABSPaymentViewModel {
  ABSPaymentService _paymentService = locator<ABSPaymentService>();

  set userBanks(List<Bank> value) {
    _userBanks = value;
    notifyListeners();
  }

  set selectedCard(PaymentCard value) {
    _selectedCard = value;
    notifyListeners();
  }

  set selectedBank(Bank value) {
    _selectedBank = value;
    notifyListeners();
  }

  set walletTransaction(List<WalletTransaction> value) {
    _walletTransactions = value;
    notifyListeners();
  }

  set userCards(List<PaymentCard> value) {
    _userCards = value;
    notifyListeners();
  }

  set wallet(List<Wallet> value) {
    _wallet = value;
    notifyListeners();
  }

  @override
  Future<Result<List<Bank>>> getBanks(String token) async {
    var result = await _paymentService.getBanks(token);

    return result;
  }

  @override
  Future<Result<List<String>>> validateBank(
      {String token, int customerId, String accountNum, String bankCode}) {
    return _paymentService.validateBank(
        token: token,
        customerId: customerId,
        accountNum: accountNum,
        bankCode: bankCode);
  }

  @override
  Future<Result<Bank>> addBank(
      {String token,
      int bankId,
      String bankName,
      String accountName,
      String accountNum}) async {
    var result = await _paymentService.addBank(
        token: token,
        bankName: bankName,
        accountNum: accountNum,
        bankId: bankId,
        accountName: accountName);

    if (result.error == false) {
      List<Bank> banks = userBanks;
      banks.add(result.data);
      userBanks = banks;
    }
    return result;
  }

  @override
  Future<Result<List<Bank>>> getCustomerBank(String token) async {
    var result = await _paymentService.getCustomerBank(token);
    if (result.error == false) {
      userBanks = result.data;
    }
    return result;
  }

  @override
  Future<Result<void>> deleteBank(String token, int bankId) async {
    var result = await _paymentService.deleteBank(token, bankId);

    if (result.error == false) {
      List<Bank> banks = userBanks;
      banks.removeWhere((element) => element.id == bankId);
      userBanks = banks;
    }
    return result;
  }

  @override
  Future<Result<List<PaymentCard>>> getUserCards(String token) async {
    var result = await _paymentService.getUserCards(token);

    if (result.error == false) {
      userCards = result.data;
    }
    return result;
  }

  @override
  Future<Result<List<Wallet>>> getWallet(String token) async {
    var result = await _paymentService.getWallet(token);

    if (result.error == false) {
      wallet = result.data;
    }
    return result;
  }

  @override
  Future<Result<Bank>> addCard(
      {String token,
      String cardNumber,
      String expiryDate,
      String cvv,
      String pin}) {
    // TODO: implement addCard
    throw UnimplementedError();
  }

  @override
  Future<Result<CardPayload>> registerNewCard(String token) {
    return _paymentService.registerNewCard(token);
  }

  @override
  Future<Result<List<WalletTransaction>>> getWalletTransactions(
      String token) async {
    var result = await _paymentService.getWalletTransactions(token);

    if (result.error == false) {
      walletTransaction = result.data;
    }
    return result;
  }

  @override
  Future<Result<void>> paymentConfirmation(
      String token, String trnasactionRef) {
    return _paymentService.paymentConfirmation(token, trnasactionRef);
  }

  @override
  set instrumentId(int value) {
    _instrumentId = value;
    notifyListeners();
  }

  @override
  set investmentName(String value) {
    _investmentName = value;
    notifyListeners();
  }

  @override
  set transactionId(int value) {
    _transactionId = value;
    notifyListeners();
  }

  @override
  set withdrawableAmount(double value) {
    _withdrawableAmount = value;
    notifyListeners();
  }

  @override
  set availableAmount(int value) {
    _amountAvailable = value;
    notifyListeners();
  }

  @override
  set pickNairaInstrument(TermInstrument value) {
    _nairaInstrument = value;
    notifyListeners();
  }

  @override
  set investmentAmount(double amount) {
    _investmentAmount = amount;
    notifyListeners();
  }

  @override
  void onKeyboardTap(String value) {
    amountController.text = amountController.value.text + value;
    notifyListeners();
  }

  @override
  set pickDollarInstrument(TermInstrument value) {
    _dollarInstrument = value;
    notifyListeners();

}
  Future<Result<void>> deleteCard(String token, int cardId) async{
    var result = await _paymentService.deleteCard(token, cardId);

    if (result.error == false) {
      List<PaymentCard> cards = userCards;
      cards.removeWhere((element) => element.id == cardId);
      userCards = cards;
    }
    return result;
  }
}