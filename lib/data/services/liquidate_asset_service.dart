import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

import '../../locator.dart';

// TODO: Refactor to follow already existing coding pattern

abstract class ABSLiquidateAssets {
  Future<Result<dynamic>> liquidateNairaInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidateDollarInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidateCorporateBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidatePromissoryNote(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidateTreasuryBill(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidateEuroBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidateFGNBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
  Future<Result<dynamic>> liquidateCommercialPapers(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token});
}

class LiquidateAssets implements ABSLiquidateAssets {
  final dio = locator<Dio>();

  final microService = "zimvest.services.investment";
  final String baseUrl = AppStrings.baseUrl;

  @override
  Future<Result<dynamic>> liquidateDollarInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    Result result = Result(error: false);
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
      var liquidateDollar = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));
      if (liquidateDollar.statusCode == 200) {
        result.error = false;
        result.data = liquidateDollar.data["message"];
      } else if (liquidateDollar.statusCode == 400) {
        result.error = true;
        result.data = liquidateDollar.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result<dynamic>> liquidateNairaInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url =
        "$baseUrl$microService/api/ZimvestTermInstruments/WithdrawNaira";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result> liquidateCommercialPapers(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url = "$baseUrl$microService/api/CommercialPapers/Withdraw";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result> liquidateCorporateBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url = "$baseUrl$microService/api/CorporateBonds/Withdraw";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result> liquidateEuroBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url = "$baseUrl$microService/api​/EuroBonds​/Withdraw";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result> liquidateFGNBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url = "$baseUrl$microService/api/FGNBonds/Withdraw";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result> liquidatePromissoryNote(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url = "$baseUrl$microService/api/PromissoryNotes/Withdraw";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }

  @override
  Future<Result> liquidateTreasuryBill(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    Result result = Result(error: false);
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
    print(body);
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    String url = "$baseUrl$microService/api/TreasuryBills/Withdraw";
    try {
      var liquidateNaira = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
            validateStatus: (status) {
              return status < 600;
            },
          ));

      print(liquidateNaira);
      if (liquidateNaira.statusCode == 200) {
        result.error = false;
        result.data = liquidateNaira.data["message"];
      } else if (liquidateNaira.statusCode == 400) {
        result.error = true;
        result.data = liquidateNaira.data["message"];
      }
    } on DioError catch (e) {
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
      throw HttpException(e.response.statusMessage);
    }
    return result;
  }
}
