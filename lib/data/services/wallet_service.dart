import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/payment/wallet.dart';
import 'package:zimvest/data/models/wired_transfer_details_model.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

import '../../locator.dart';

// TODO: Refactor to follow already existing coding pattern
abstract class ABSWalletService {
  Future<List<Wallet>> getWallets(String token);
  Future<List<WalletTransaction>> getWalletsTransactions(String token);
  Future<Result<dynamic>> fundWallet(
      {String token,
      num sourceAmount,
      num exchangeAmount,
      String currency,
      int fundingSource});
  Future<Result<dynamic>> fundWalletWired(
      {String token,
      num wiredTransferAmount,
      int fundingSource,
      File proofOfPayment,
      int intermediaryBankType});
  Future<Result<List<WiredTransferDetails>>> getWiredTransferDetails(
      String token);
}

class WalletService implements ABSWalletService {
  final dio = locator<Dio>();
  final microService = "zimvest.services.wallet";

  @override
  Future<List<Wallet>> getWallets(String token) async {
    final url = "$microService/api/Wallet/wallets";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    print(url);
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
    return null;
  }

  @override
  Future<List<WalletTransaction>> getWalletsTransactions(String token) async {
    final url = "$microService/api/Wallet/WalletTransaction";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    print(url);
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
    return null;
  }

  @override
  Future<Result<void>> fundWallet(
      {String token,
      num sourceAmount,
      num exchangeAmount,
      String currency,
      int fundingSource}) async {
    Result<void> result = Result(error: false);
    final url = "$microService/api/Wallet/fundwallet";

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    FormData data = FormData.fromMap({
      "WalletFundingSource": fundingSource,
      "Currency": currency,
      "SourceAmount": sourceAmount,
      "ExchangeAmount": exchangeAmount
    });
    print(data);
    print(url);
    try {
      final fundWallet = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      print("pppvg dd ${fundWallet.data}");
      print("pppvg 1111 ${fundWallet.statusCode}");
      if (fundWallet.statusCode == 200) {
        result.error = false;
        result.errorMessage = fundWallet.data["message"];
      } else if (fundWallet.statusCode == 400) {
        result.error = true;
        result.errorMessage = fundWallet.data["message"];
      } else {
        result.error = true;
        result.errorMessage = "Wallet could not be funded";
      }
    } on DioError catch (e) {
      result.error = true;
      if (e.response.data == null) {
        result.errorMessage = "Error Message";
      } else {
        if (e.response.data is Map) {
          result.errorMessage = e.response.data['message'];
        } else {
          result.errorMessage = "Error Message";
        }
      }
    }
    return result;
  }

  @override
  Future<Result> fundWalletWired(
      {String token,
      num wiredTransferAmount,
      int fundingSource,
      File proofOfPayment,
      int intermediaryBankType}) async {
    final url = "$microService/api/Wallet/fundwallet";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    Result result = Result(error: false);
    FormData data = FormData.fromMap({
      "WalletFundingSource": fundingSource,
      "ProofOfPayment.DocumentFile": proofOfPayment.path,
      "WireTransferAmount": wiredTransferAmount,
      "IntermediaryBankType": intermediaryBankType,
    });
    try {
      final fundWalletWired = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      print("pppvg dd ${fundWalletWired.data}");
      if (fundWalletWired.statusCode == 200) {
        result.error = false;
        result.errorMessage = fundWalletWired.data["message"];
      } else if (fundWalletWired.statusCode == 400) {
        result.error = true;
        result.errorMessage = fundWalletWired.data["message"];
      } else {
        result.error = true;
        result.errorMessage = "Wallet could not be funded";
      }
    } on DioError catch (e) {
      result.error = true;
      if (e.response.data == null) {
        result.errorMessage = "Error Message";
      } else {
        if (e.response.data is Map) {
          result.errorMessage = e.response.data['message'];
        } else {
          result.errorMessage = "Error Message";
        }
      }
    }
    return result;
  }

  @override
  Future<Result<List<WiredTransferDetails>>> getWiredTransferDetails(
      String token) async {
    Result<List<WiredTransferDetails>> result = Result(error: false);
    final url = "${AppStrings.baseUrl}$microService/api/Options";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var getDetails = await dio.get(url, options: Options(headers: headers));
      if (getDetails.statusCode == 200) {
        result.error = false;
        var res = getDetails.data["data"];
        List<WiredTransferDetails> details = [];
        (res as List).forEach((element) {
          details.add(WiredTransferDetails.fromJson(element));
        });
        result.data = details;
      }
    } on DioError catch (e) {
      print(e.toString());
      result.errorMessage = e.response.statusMessage;
      result.error = true;
    }
    return result;
  }
}
