import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/investment/bond_amount_payable_model.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:zimvest/utils/result.dart';

import '../../locator.dart';

abstract class ABSFixedIncomeInvestmentService {
  Future<dynamic> buyEuroBond(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount});
  Future<dynamic> buyFGNBond(
      {int productId,
      String token,
      int fundingChannel,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount});
  Future<dynamic> buyPromissoryNote(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      bool upFront,
      num faceValue,
      num investmentAmount});
  Future<dynamic> buyTreasuryBill(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      bool upFront,
      num faceValue,
      num investmentAmount});
  Future<dynamic> buyCommercialPaper(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      bool upFront,
      num faceValue,
      num investmentAmount});
  Future<dynamic> buyCorporateBond(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount});

  Future<AmountPayableResponse> calculateAmountPayable(
      {String token,
      int instrumentId,
      int instrumentType,
      num investmentAmount,
      num rate,
      String instrumentName,
      DateTime maturityDate,
      int productId,
      bool upFront});
}

class FixedIncomeInvestmentService implements ABSFixedIncomeInvestmentService {
  final dio = locator<Dio>();

  final microService = "zimvest.services.investment";
  @override
  Future<dynamic> buyCommercialPaper(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      bool upFront,
      num faceValue,
      num investmentAmount}) async {
    var url = "${AppStrings.baseUrl}$microService/api/CorporateBonds";

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "RateValue": rate,
      "IntermediaryBankType": intermediaryBankType,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "FaceValue": faceValue,
      "InvestmentAmount": investmentAmount,
      "UpFront": upFront
    });

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var buyCommercialPaper = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (buyCommercialPaper.statusCode == 200) {
        return buyCommercialPaper.data["message"];
      } else if (buyCommercialPaper.statusCode == 400) {
        return buyCommercialPaper.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<dynamic> buyCorporateBond(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount}) async {
    var url = "${AppStrings.baseUrl}$microService/api/CorporateBonds";

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "RateValue": rate,
      "IntermediaryBankType": intermediaryBankType,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "FaceValue": faceValue,
      "InvestmentAmount": investmentAmount
    });

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var buyCorporateBond = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (buyCorporateBond.statusCode == 200) {
        return buyCorporateBond.data["message"];
      } else if (buyCorporateBond.statusCode == 400) {
        return buyCorporateBond.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<dynamic> buyEuroBond(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount}) async {
    var url = "${AppStrings.baseUrl}$microService/api/EuroBonds";

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "RateValue": rate,
      "IntermediaryBankType": intermediaryBankType,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "FaceValue": faceValue,
      "InvestmentAmount": investmentAmount
    });

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var buyEuroBond = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print(buyEuroBond.data);
      if (buyEuroBond.statusCode == 200) {
        return buyEuroBond.data["message"];
      } else if (buyEuroBond.statusCode == 400) {
        return buyEuroBond.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<dynamic> buyFGNBond(
      {int productId,
      String token,
      int fundingChannel,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount}) async {
    var url = "${AppStrings.baseUrl}$microService/api/FGNBonds";

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "RateValue": rate,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "FaceValue": faceValue,
      "InvestmentAmount": investmentAmount
    });

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var buyFGNBond = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print(buyFGNBond.data);
      if (buyFGNBond.statusCode == 200) {
        return buyFGNBond.data["message"];
      } else if (buyFGNBond.statusCode == 400) {
        return buyFGNBond.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<dynamic> buyPromissoryNote(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      bool upFront,
      num faceValue,
      num investmentAmount}) async {
    var url = "${AppStrings.baseUrl}$microService/api/PromissoryNotes";

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "RateValue": rate,
      "IntermediaryBankType": intermediaryBankType,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "FaceValue": faceValue,
      "InvestmentAmount": investmentAmount,
      "UpFront": upFront
    });

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var buyPromissoryNote = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (buyPromissoryNote.statusCode == 200) {
        return buyPromissoryNote.data["message"];
      } else if (buyPromissoryNote.statusCode == 400) {
        return buyPromissoryNote.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<dynamic> buyTreasuryBill(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      bool upFront,
      num faceValue,
      num investmentAmount}) async {
    var url = "${AppStrings.baseUrl}$microService/api/TreasuryBills";
    print(url);
    FormData data = FormData.fromMap({
      "ProductId": productId,
      "RateValue": rate,
      "IntermediaryBankType": intermediaryBankType,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "FaceValue": faceValue,
      "InvestmentAmount": investmentAmount,
      "UpFront": upFront
    });
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var buyTreasuryBill = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (buyTreasuryBill.statusCode == 200) {
        return buyTreasuryBill.data["message"];
      } else if (buyTreasuryBill.statusCode == 400) {
        return buyTreasuryBill.data["message"];
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<AmountPayableResponse> calculateAmountPayable(
      {String token,
      int instrumentId,
      int instrumentType,
      num investmentAmount,
      num rate,
      String instrumentName,
      DateTime maturityDate,
      int productId,
      bool upFront}) async {
    var url =
        "${AppStrings.baseUrl}$microService/api/Calculator/calculateamountpayable";
    print(url);
    FormData data = FormData.fromMap({
      "ProductId": productId,
      "Rate": rate,
      "InstrumentName": instrumentName,
      "InstrumentType": instrumentType,
      "MaturityDate": maturityDate,
      "InvestmentAmount": investmentAmount,
      "UpFront": upFront,
      "InstrumentId": instrumentId
    });
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var calculateAmountPayable = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (calculateAmountPayable.statusCode == 200) {
        return AmountPayableResponse.fromJson(
            calculateAmountPayable.data["data"]);
      } else if (calculateAmountPayable.statusCode == 400) {
        return null;
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }
}
