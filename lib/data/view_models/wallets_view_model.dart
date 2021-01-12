import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/wallets/wallets_model.dart';
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

  bool _status = false;
  bool get status => _status;

  String _message = "";
  String get message => _message;

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

  Future<void> getCards()async{
    setBusy(true);
    String token = _localStorage.getUser().token;
    var cards = await _paymentService.getUserCards(token);
    this.cards = cards.data;
    setBusy(false);
    notifyListeners();
  }

  Future<void> fundWallet(num dollarAmount, num nairaAmount) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var fundWallet = await _walletService.fundWallet(
        amountUSD: dollarAmount, token: token, amountNGN: nairaAmount);
    print(fundWallet);
    if (fundWallet == "Successfully Processed Payment") {
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
}
