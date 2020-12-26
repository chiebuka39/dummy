import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/payment/card_payload.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSPaymentViewModel extends ChangeNotifier{

  PaymentCard _selectedCard;
  Bank _selectedBank;
  PaymentCard get selectedCard => _selectedCard;
  Bank get selectedBank => _selectedBank;
  List<Bank> _userBanks;
  List<WalletTransaction> _walletTransactions = [];
  List<PaymentCard> _userCards;
  List<Bank> get userBanks => _userBanks;
  List<PaymentCard> get userCards => _userCards;

  Wallet _wallet;
  Wallet get wallet => _wallet;
  List<WalletTransaction> get walletTransaction => _walletTransactions;

  set userBanks(List<Bank> value);
  set walletTransaction(List<WalletTransaction> value);
  set wallet(Wallet value);
  set selectedCard(PaymentCard value);
  set selectedBank(Bank value);
  set userCards(List<PaymentCard> value);

  Future<Result<List<Bank>>> getBanks(String token);
  Future<Result<List<String>>> validateBank({String token, int customerId,
    String accountNum, String bankCode});
  Future<Result<List<Bank>>> getCustomerBank(String token);
  Future<Result<List<PaymentCard>>> getUserCards(String token);
  Future<Result<Wallet>> getWallet(String token);
  Future<Result<List<WalletTransaction>>> getWalletTransactions(String token);
  Future<Result<Bank>> addBank(
      {String token,
        int bankId,
        String bankName,
        String accountName,
        String accountNum});
  Future<Result<void>> deleteBank(String token, int bankId);
  Future<Result<Bank>> addCard({String token, String cardNumber,
    String expiryDate, String cvv, String pin});
  Future<Result<CardPayload>> registerNewCard(String token);
  Future<Result<void>> paymentConfirmation(String token, String trnasactionRef);

}

class PaymentViewModel extends ABSPaymentViewModel{
  ABSPaymentService _paymentService = locator<ABSPaymentService>();

  set userBanks(List<Bank> value){
    _userBanks = value;
    notifyListeners();
  }

  set selectedCard(PaymentCard value){
    _selectedCard = value;
    notifyListeners();
  }

  set selectedBank(Bank value){
    _selectedBank = value;
    notifyListeners();
  }

  set walletTransaction(List<WalletTransaction> value){
    _walletTransactions = value;
    notifyListeners();
  }

  set userCards(List<PaymentCard> value){
    _userCards = value;
    notifyListeners();
  }

  set wallet(Wallet value){
    _wallet = value;
    notifyListeners();
  }


  @override
  Future<Result<List<Bank>>> getBanks(String token)async {
     var result =await _paymentService.getBanks(token);

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

  @override
  Future<Result<List<PaymentCard>>> getUserCards(String token)async {
    var result =  await _paymentService.getUserCards(token);

    if(result.error == false){
      userCards = result.data;
    }
    return result;
  }

  @override
  Future<Result<Wallet>> getWallet(String token) async{
    var result =  await _paymentService.getWallet(token);

    if(result.error == false){
      wallet = result.data;
    }
    return result;
  }

  @override
  Future<Result<Bank>> addCard({String token, String cardNumber, String expiryDate, String cvv, String pin}) {
    // TODO: implement addCard
    throw UnimplementedError();
  }

  @override
  Future<Result<CardPayload>> registerNewCard(String token) {
    return _paymentService.registerNewCard(token);
  }

  @override
  Future<Result<List<WalletTransaction>>> getWalletTransactions(String token) async{
    var result =  await _paymentService.getWalletTransactions(token);

    if(result.error == false){
      walletTransaction = result.data;
    }
    return result;
  }

  @override
  Future<Result<void>> paymentConfirmation(String token, String trnasactionRef) {
    return _paymentService.paymentConfirmation(token, trnasactionRef);
  }

}