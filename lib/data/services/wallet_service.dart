import 'package:dio/dio.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/wallets/wallets_model.dart';

import '../../locator.dart';

abstract class ABSWalletService {
  Future<Wallets> getWallets();
  Future<WalletTransaction> getWalletsTransactions();
}

class WalletService implements ABSWalletService {
  final dio = locator<Dio>();
  final microService = "zimvest.services.wallet";
  @override
  Future<Wallets> getWallets() async {
    // TODO: implement getWallets
    throw UnimplementedError();
  }

  @override
  Future<WalletTransaction> getWalletsTransactions() async {
    // TODO: implement getWalletsTransactions
    throw UnimplementedError();
  }
}
