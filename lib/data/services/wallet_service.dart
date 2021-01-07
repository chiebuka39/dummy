import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/utils/strings.dart';

import '../../locator.dart';

abstract class ABSWalletService {
  Future<List<Wallet>> getWallets(String token);
  Future<List<WalletTransaction>> getWalletsTransactions(String token);
  Future<dynamic> fundWallet(
      {String token, num amountUSD, num amountNGN});
}

class WalletService implements ABSWalletService {
  final dio = locator<Dio>();
  final microService = "zimvest.services.wallet";

  @override
  Future<List<Wallet>> getWallets(String token) async {
    final url = "${AppStrings.baseUrl}$microService/api/Wallet/wallets";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var getWallets = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (getWallets.statusCode == 200) {
        final Iterable result = getWallets.data["data"];
        return result.map((e) => Wallet.fromJson(e)).toList();
      } else if (getWallets.statusCode == 400) {
        return null;
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
  }

  @override
  Future<List<WalletTransaction>> getWalletsTransactions(String token) async {
    final url =
        "${AppStrings.baseUrl}$microService/api/Wallet/WalletTransaction";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var getWalletTransactions = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (getWalletTransactions.statusCode == 200) {
        final Iterable result = getWalletTransactions.data["data"];
        return result.map((e) => WalletTransaction.fromJson(e)).toList();
      } else if (getWalletTransactions.statusCode == 400) {
        return null;
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
  }

  @override
  Future fundWallet({String token, num amountUSD, num amountNGN}) async {
    final url = "${AppStrings.baseUrl}$microService/api/Wallet/fundwallet";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      final fundWallet = await dio.post(
        url,
        data: {"amountUSD": amountUSD, "amountNGN": amountNGN},
        options: Options(headers: headers),
      );
      if (fundWallet.statusCode == 200) {
        return fundWallet.data["message"];
      } else if (fundWallet.statusCode == 400) {
        return fundWallet.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }
}
