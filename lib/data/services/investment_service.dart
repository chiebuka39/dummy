import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/investment/bank_payment_details.dart';
import 'package:zimvest/data/models/investment/bond_amount_payable_model.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
import 'package:zimvest/data/models/investment/gotten_naira_rate.dart';
import 'package:zimvest/data/models/investment/investment_fixed_fund.dart';
import 'package:zimvest/data/models/investment/investment_fund_model.dart';
import 'package:zimvest/data/models/investment/investment_termed_fund.dart';
import 'package:zimvest/data/models/investment/money_market_fund.dart';
import 'package:zimvest/data/models/investment/mutual_item_detail.dart';
import 'package:zimvest/data/models/investment/term_instruments.dart';

import 'dart:async';
import 'dart:convert';

import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/savings/savings_frequency.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';
import 'package:http_parser/http_parser.dart';

abstract class ABSInvestmentService {
  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation(
      {String token});
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation(
      {String token});
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation({String token});
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities(
      {String token});
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities(
      {String token});
  Future<Result<List<InvestmentActivity>>> getTermFundActivities(
      {String token});
  Future<Result<List<TermInstrument>>> getDollarTermInstruments({String token});
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token});
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token});
  Future<Result<dynamic>> buyMoneyMarketFund(
      {String token,
      int productId,
      double amount,
      int fundingChannel,
      int cardId,
      int directDebitFrequency,
      File documentFile});
  Future<Result<List<MutualFund>>> getDollarFund({String token});
  Future<Result<TreasuryBill>> getTreasuryBill({String token});
  Future<Result<CommercialPaper>> getCommercialPaper({String token});
  Future<Result<FGNBond>> getFGNBond({String token});
  Future<Result<PromissoryNote>> getPromissoryNotes({String token});
  Future<Result<EuroBond>> getEuroBond({String token});
  Future<Result<CorporateBond>> getCorporateBond({String token});
  Future<Result<Fund>> getFundDetails(
      {String token, String fundName, String fundId});
  Future<Result<Fund>> getFixedFundDetails(
      {String token, String fixedIncomeId, String fixedIncomeName});
  Future<Result<Fund>> getTermFundDetails(
      {String token, String termInstrumentId, String termInstrumentName});
  Future<Result<dynamic>> buyNairaInstrument(
      {int productId,
      int cardId,
      int fundingChannel,
      String proofOfPayment,
      double amount,
      String uniqueName,
      String token});
  Future<Result<dynamic>> buyDollarnstrument(
      {int productId,
      int beneficiaryBankType,
      int fundingChannel,
      String proofOfPayment,
      double amount,
      double nairaAmount,
      String uniqueName,
      String token});

  Future<Result<dynamic>> buyEuroBond(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount});
  Future<Result<dynamic>> buyFGNBond(
      {int productId,
      String token,
      int fundingChannel,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount});
  Future<Result<dynamic>> buyPromissoryNote(
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
  Future<Result<dynamic>> buyTreasuryBill(
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
  Future<Result<dynamic>> buyCommercialPaper(
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
  Future<Result<dynamic>> buyCorporateBond(
      {int productId,
      String token,
      int fundingChannel,
      int intermediaryBankType,
      num amount,
      num rate,
      String uniqueName,
      num faceValue,
      num investmentAmount});

  Future<dynamic> calculateAmountPayable(
      {String token,
      int instrumentId,
      int instrumentType,
      num investmentAmount,
      num rate,
      String instrumentName,
      DateTime maturityDate,
      int productId,
      bool upFront});

  Future<ConvertedDollarRate> calculateRate({num amountUsd, String token});
  Future<Result<GottenRate>> getRate(String token);
}

class InvestmentService extends ABSInvestmentService {
  final dio = locator<Dio>();

  final microService = "zimvest.services.investment";
  @override
  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation(
      {String token}) async {
    Result<List<InvestmentMutualFund>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/mutualfundvaluation";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<InvestmentMutualFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentMutualFund.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      print("erroreeee ${e.response.data}");
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation(
      {String token}) async {
    Result<List<InvestmentFixedFund>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/directfixedincomevaluation";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<InvestmentFixedFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentFixedFund.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response?.data is Map) {
        print(e.response.data);

        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation(
      {String token}) async {
    Result<List<InvestmentTermFund>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/terminstrumentvaluation";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<InvestmentTermFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentTermFund.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response?.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities(
      {String token}) async {
    Result<List<InvestmentActivity>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards"
        "/mutualfundinvestmentactivities?StartDate=&EndDate=";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<InvestmentActivity> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentActivity.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities(
      {String token}) async {
    Result<List<InvestmentActivity>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards"
        "/fixedincomeinvestmentactivities?StartDate=&EndDate=";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<InvestmentActivity> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentActivity.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentActivity>>> getTermFundActivities(
      {String token}) async {
    Result<List<InvestmentActivity>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards/"
        "terminstrumentInvestmentactivities?StartDate=&EndDate=";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<InvestmentActivity> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentActivity.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response.data is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token}) async {
    Result<List<MutualFund>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}zimvest.services.investment/"
        "api/MutualFunds/getmoneymarketfunds";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<MutualFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(MutualFund.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response is Map) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<MutualFund>>> getDollarFund({String token}) async {
    Result<List<MutualFund>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}zimvest.services.investment/api/MutualFunds/getdollarfunds";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<MutualFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(MutualFund.fromJson(chaList));
        });
        result.data = types;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<CommercialPaper>> getCommercialPaper({String token}) async {
    Result<CommercialPaper> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}$microService/api/CommercialPapers/grouped";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        result.data = CommercialPaper.fromJson(response1);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }
    print("Commercial Paper ${result.data}");
    return result;
  }

  @override
  Future<Result<CorporateBond>> getCorporateBond({String token}) async {
    Result<CorporateBond> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}$microService/api/CorporateBonds/grouped";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      // print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        // List<CorporateBond> channels = [];
        // (response1['data'] as List).forEach((chaList) {
        //   //initialize Chat Object
        //   channels.add(CorporateBond.fromJson(chaList));
        // });
        result.data = CorporateBond.fromJson(response1);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }
    print("corporatebond ${result.data}");
    return result;
  }

  @override
  Future<Result<EuroBond>> getEuroBond({String token}) async {
    Result<EuroBond> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}$microService/api/EuroBonds/grouped";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      // print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        // List<EuroBond> channels = [];
        // (response1['data'] as List).forEach((chaList) {
        //   //initialize Chat Object
        //   channels.add(EuroBond.fromJson(chaList));
        // });
        result.data = EuroBond.fromJson(response1);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }
    print("EuroBond ${result.data}");
    return result;
  }

  @override
  Future<Result<FGNBond>> getFGNBond({String token}) async {
    Result<FGNBond> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}$microService/api/FGNBonds/grouped";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii $response1");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        // List<FGNBond> channels = [];
        // (response1['data'] as List).forEach((chaList) {
        //   //initialize Chat Object
        //   channels.add(FGNBond.fromJson(chaList));
        // });
        result.data = FGNBond.fromJson(response1);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    print("FGNBond ${result.data}");
    return result;
  }

  @override
  Future<Result<PromissoryNote>> getPromissoryNotes({String token}) async {
    Result<PromissoryNote> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}$microService/api/PromissoryNotes/grouped";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii $response1");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        // List<PromissoryNotes> channels = [];
        // (response1['data'] as List).forEach((chaList) {
        //   //initialize Chat Object
        //   channels.add(PromissoryNotes.fromJson(chaList));
        // });
        result.data = PromissoryNote.fromJson(response1);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }
    print("Promissory Note ${result.data}");
    return result;
  }

  @override
  Future<Result<TreasuryBill>> getTreasuryBill({String token}) async {
    Result<TreasuryBill> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url = "${AppStrings.baseUrl}$microService/api/TreasuryBills/grouped";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      // print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        // List<TreasuryBill> channels = [];
        // (response1['data'] as List).forEach((chaList) {
        //   //initialize Chat Object
        //   channels.add(TreasuryBill.fromJson(chaList));
        // });
        result.data = TreasuryBill.fromJson(response1);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }
    print("Treasury Bill ${result.data.tBillsItems}");
    return result;
  }

  @override
  Future<Result<List<TermInstrument>>> getDollarTermInstruments(
      {String token}) async {
    Result<List<TermInstrument>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/ZimvestTermInstruments/getdollarterminstruments";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<TermInstrument> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(TermInstrument.fromJson(chaList));
        });
        result.data = channels;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<TermInstrument>>> getNairaTermInstruments(
      {String token}) async {
    Result<List<TermInstrument>> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/ZimvestTermInstruments/getnairaterminstruments";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<TermInstrument> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(TermInstrument.fromJson(chaList));
        });
        result.data = channels;
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Fund>> getFundDetails(
      {String token, String fundName, String fundId}) async {
    Result<Fund> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/managefund?FundId=$fundId&FundName=$fundName";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;

        result.data = Fund.fromJson(response1['data']);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<dynamic>> buyMoneyMarketFund(
      {String token,
      int productId,
      double amount,
      int fundingChannel,
      int cardId,
      int directDebitFrequency,
      File documentFile}) async {
    Result<dynamic> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    FormData body;
    if (fundingChannel == 1) {
      body = FormData.fromMap({
        'ProductId': productId,
        'Amount': amount,
        'FundingChannel': fundingChannel,
        'CardId': cardId,
        'DirectDebitFrequency': directDebitFrequency,
      });
    } else if (fundingChannel == 2) {
      Uint8List bytes;
      if (documentFile != null) {
        bytes = await File(documentFile.path).readAsBytes();
        String base64Encode(List<int> bytes) => base64.encode(bytes);
      }

      body = FormData.fromMap({
        'ProductId': productId,
        'Amount': amount,
        'FundingChannel': fundingChannel,
        'DirectDebitFrequency': -1,
        "ProofOfPayment.DocumentFile": bytes == null ? '' : base64Encode(bytes),
      });
    }

    var url =
        "${AppStrings.baseUrl}$microService/api/MutualFunds/buymoneymarketfund";
    print("url $url");
    print("body ${body.fields}");
    try {
      var response =
          await dio.post(url, options: Options(headers: headers), data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        if (documentFile == null && fundingChannel == 2) {
          result.data = BankPaymentDetails.fromJson(response1['data']);
        }
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Fund>> getFixedFundDetails(
      {String token, String fixedIncomeId, String fixedIncomeName}) async {
    Result<Fund> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/managefixedincome?FixedIncomeId=$fixedIncomeId&FixedIncomeName=$fixedIncomeName";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;

        result.data = Fund.fromJson(response1['data']);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Fund>> getTermFundDetails(
      {String token,
      String termInstrumentId,
      String termInstrumentName}) async {
    Result<Fund> result = Result(error: false);

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    var url =
        "${AppStrings.baseUrl}$microService/api/Dashboards/manageterminstrument?TermInstrumentId=$termInstrumentId&TermInstrumentName=$termInstrumentName";
    print("url $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;

        result.data = Fund.fromJson(response1['data']);
      }
    } on DioError catch (e) {
      print("error $e}");
      if (e.response != null) {
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<dynamic>> buyDollarnstrument(
      {int productId,
      int beneficiaryBankType,
      int fundingChannel,
      String proofOfPayment,
      double amount,
      double nairaAmount,
      String uniqueName,
      String token}) async {
    var url =
        "${AppStrings.baseUrl}$microService/api/ZimvestTermInstruments/buydollarterminstrument";

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName,
      "BeneficiaryBankType": beneficiaryBankType,
    });
    Result<dynamic> result = Result(error: false);

    try {
      var buydollaInstrument = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print("Success: ${buydollaInstrument.data}");
      if (buydollaInstrument.statusCode == 200) {
        print("Success: ${buydollaInstrument.data}");
        result.data = buydollaInstrument.data;
        return result.data;
      }
      if (buydollaInstrument.statusCode == 400) {
        print("Failure: ${buydollaInstrument.data}");
        result.data = buydollaInstrument.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    } catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return result;
  }

  @override
  Future<Result<dynamic>> buyNairaInstrument(
      {int productId,
      int cardId,
      int fundingChannel,
      String proofOfPayment,
      double amount,
      String uniqueName,
      String token}) async {
    var url =
        "${AppStrings.baseUrl}$microService/api/ZimvestTermInstruments/buynairaterminstrument";

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};

    // var imgname = DateTime.now().millisecondsSinceEpoch.toString();

    FormData data = FormData.fromMap({
      "ProductId": productId,
      "FundingChannel": fundingChannel,
      "Amount": amount,
      "UniqueName": uniqueName
    });
    Result<dynamic> result = Result(error: false);

    try {
      var buyNairaInstrument = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print("Success: ${buyNairaInstrument.data}");
      if (buyNairaInstrument.statusCode == 200) {
        print("Success: ${buyNairaInstrument.data}");
        result.data = buyNairaInstrument.data;
        return result.data;
      }
      if (buyNairaInstrument.statusCode == 400) {
        print("Failure: ${buyNairaInstrument.data}");
        result.data = buyNairaInstrument.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    } catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return result;
  }

  @override
  Future<Result> buyCommercialPaper(
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
    Result<dynamic> result = Result(error: false);
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
        result.data = buyCommercialPaper.data;
        return result.data;
      } else if (buyCommercialPaper.statusCode == 400) {
        result.data = buyCommercialPaper.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<Result> buyCorporateBond(
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
    Result<dynamic> result = Result(error: false);
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
        result.data = buyCorporateBond.data;
        return result.data;
      } else if (buyCorporateBond.statusCode == 400) {
        result.data = buyCorporateBond.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return result;
  }

  @override
  Future<Result<dynamic>> buyEuroBond(
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
    Result<dynamic> result = Result(error: false);
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
        result.data = buyEuroBond.data;
        return result.data;
      } else if (buyEuroBond.statusCode == 400) {
        result.data = buyEuroBond.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<Result<dynamic>> buyFGNBond(
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
    Result<dynamic> result = Result(error: false);
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
        result.data = buyFGNBond.data;
        return result.data;
      } else if (buyFGNBond.statusCode == 400) {
        result.data = buyFGNBond.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<Result> buyPromissoryNote(
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
    Result<dynamic> result = Result(error: false);
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
        result.data = buyPromissoryNote.data;
        return result.data;
      } else if (buyPromissoryNote.statusCode == 400) {
        result.error = true;
        result.data = buyPromissoryNote.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<Result> buyTreasuryBill(
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
    Result<dynamic> result = Result(error: false);
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
      print(buyTreasuryBill.data);
      if (buyTreasuryBill.statusCode == 200) {
        result.data = buyTreasuryBill.data;
        return result.data;
      } else if (buyTreasuryBill.statusCode == 400) {
        result.error = true;
        result.data = buyTreasuryBill.data;
        return result.data;
      }
    } on DioError catch (e) {
      result.error = true;
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<dynamic> calculateAmountPayable(
      {String token,
      int instrumentId,
      int instrumentType,
      num investmentAmount,
      num rate,
      String instrumentName,
      DateTime maturityDate,
      int productId,
      bool upFront}) async {
    print("instrumentType $instrumentType");
    var url =
        "${AppStrings.baseUrl}$microService/api/Calculator/calculateamountpayable";

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
    // Result<AmountPayableResponse> result = Result(error: false);
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
      print(calculateAmountPayable.statusCode);
      print(calculateAmountPayable.data);
      if (calculateAmountPayable.statusCode == 200) {
        // result.data = AmountPayableResponse.fromJson(calculateAmountPayable.data["data"]);
        return AmountPayableResponse.fromJson(
            jsonDecode(calculateAmountPayable.data["data"]));
      } else if (calculateAmountPayable.statusCode == 400) {
        // result.data = calculateAmountPayable.data["data"];
        return null;
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<ConvertedDollarRate> calculateRate(
      {num amountUsd, String token}) async {
    var url = "${AppStrings.baseUrl}$microService/api/Calculator/calculaterate";

    FormData data = FormData.fromMap({
      "AmountUSD": amountUsd,
    });

    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var calculateRate = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (calculateRate.statusCode == 200) {
        return ConvertedDollarRate.fromJson(calculateRate.data["data"]);
      } else if (calculateRate.statusCode == 400) {
        return calculateRate.data;
      }
    } on DioError catch (e) {
      print(e.message.toString());
      throw Exception(e.response.toString());
    }
    return null;
  }

  @override
  Future<Result<GottenRate>> getRate(String token) async {
    var url = "${AppStrings.baseUrl}$microService/api/Calculator/getrate";
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    Result<GottenRate> result = Result(error: false);
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        result.data = GottenRate.fromJson(response1['data']);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }
    return result;
  }
}
