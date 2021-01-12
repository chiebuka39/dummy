import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/transactions_portfolio/dollar_model.dart';
import 'package:zimvest/data/models/transactions_portfolio/naira_model.dart';
import 'package:zimvest/utils/strings.dart';

import '../../locator.dart';

abstract class ABSTransactionService {
  Future<List<NairaPortfolioTransactions>> getNairaTransactions(String token);
  Future<List<DollarPortfolioTransactions>> getDollarTransactions(String token);
}

class TransactionService implements ABSTransactionService {
  final dio = locator<Dio>();
  final microService = "zimvest.services.investment";

  @override
  Future<List<DollarPortfolioTransactions>> getDollarTransactions(
      String token) async {
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/dollarportfoliotransaction";
    print("pppnn ${url}");
    try {
      var getTransactions = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (getTransactions.statusCode == 200) {
        print("122222 ${getTransactions.data}");
        final Iterable result = getTransactions.data["data"];
        return result
            .map((e) => DollarPortfolioTransactions.fromJson(e))
            .toList();
      } else if (getTransactions.statusCode == 400) {
        return null;
      }
    } on DioError catch (e) {
      throw Exception(e.response.statusMessage.toString());
    }
    return null;
  }

  @override
  Future<List<NairaPortfolioTransactions>> getNairaTransactions(
      String token) async {
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/nairaportfoliotransaction";
    print("pppnn ${url}");
    try {
      var getTransactions = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (getTransactions.statusCode == 200) {
        print("111111 ${getTransactions.data}");
        final Iterable result = getTransactions.data["data"];
        return result
            .map((e) => NairaPortfolioTransactions.fromJson(e))
            .toList();
      } else if (getTransactions.statusCode == 400) {
        return null;
      }
    } on DioError catch (e) {
      throw Exception(e.response.statusMessage.toString());
    }
    return null;
  }
}
