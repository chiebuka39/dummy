import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/wallets/wallets_model.dart';
import 'package:zimvest/data/services/wallet_service.dart';
import 'package:zimvest/data/view_models/base_model.dart';

import '../../locator.dart';

class WalletViewModel extends BaseViewModel {
  ABSWalletService _walletService = locator<ABSWalletService>();
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  List<Wallet> wallets = List<Wallet>();
  List<WalletTransaction> walletTransaction = List<WalletTransaction>();

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
}
