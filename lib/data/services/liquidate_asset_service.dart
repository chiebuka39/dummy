import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/utils/strings.dart';

import '../../locator.dart';

abstract class ABSLiquidateAssets {
  Future<dynamic> liquidateNairaInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      int amount,
      String pin,
      double withdrawableAmount,
      String requestSource,
      String token});
  Future<dynamic> liquidateDollarInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      int amount,
      String pin,
      double withdrawableAmount,
      String requestSource,
      String token});
}

class LiquidateAssets implements ABSLiquidateAssets {
  final dio = locator<Dio>();

  final microService = "zimvest.services.investment";
  final String baseUrl = AppStrings.baseUrl;

  @override
  Future liquidateDollarInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      int amount,
      String pin,
      double withdrawableAmount,
      String requestSource,
      String token}) async {
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    Map<String, dynamic> body = {
      "transactionId": transactionId,
      "termInstrumentId": instrumentId,
      "bankId": bankId,
      "withdrawalOption": withdrawalOption,
      "amount": amount,
      // "password": "sqtring",
      "pin": pin,
      "withdrawableAmount": withdrawableAmount,
      "requestSource": "MOBILE"
    };
    String url =
        "$baseUrl$microService/api/ZimvestTermInstruments/WithdrawDollar";
    try {
      var liquidateDollar =
          await dio.post(url, data: body, options: Options(headers: headers));
      if (liquidateDollar.statusCode == 200) {
        return "Success";
      } else if (liquidateDollar.statusCode == 400) {
        return "Failed";
      }
    } on DioError catch (e) {
      print(e.response.statusMessage);
      throw Exception(e.response.statusMessage);
    }
  }

  @override
  Future liquidateNairaInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      int amount,
      String pin,
      double withdrawableAmount,
      String requestSource,
      String token}) async {
    Map<String, dynamic> body = {
      "transactionId": transactionId,
      "termInstrumentId": instrumentId,
      "bankId": bankId,
      "withdrawalOption": withdrawalOption,
      "amount": amount,
      // "password": "string",
      "pin": pin,
      "withdrawableAmount": withdrawableAmount,
      "requestSource": "MOBILE"
    };
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url =
        "$baseUrl$microService/api/ZimvestTermInstruments/WithdrawNaira";
    print(body);
    print(url);
    try {
      var liquidateNaira =
          await dio.post(url, data: body, options: Options(headers: headers));
      if (liquidateNaira.statusCode == 200) {
        return "Success";
      } else if (liquidateNaira.statusCode == 400) {
        return "Failed";
      }
    } on DioError catch (e) {
      print(e.response.statusMessage);
      throw Exception(e.response.statusMessage);
    }
  }
}
