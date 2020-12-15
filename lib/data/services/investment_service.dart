import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/investment/bank_payment_details.dart';
import 'package:zimvest/data/models/investment/fixed_models.dart';
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

abstract class ABSInvestmentService{
  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation({String token});
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation({String token});
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation({String token});
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities({String token});
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities({String token});
  Future<Result<List<InvestmentActivity>>> getTermFundActivities({String token});
  Future<Result<List<TermInstrument>>> getDollarTermInstruments({String token});
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token});
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token});
  Future<Result<dynamic>> buyMoneyMarketFund({
    String token,
    int productId,
    double amount,
    int fundingChannel,
    int cardId,
    int directDebitFrequency,
    File documentFile
  });
  Future<Result<List<MutualFund>>> getDollarFund({String token});
  Future<Result<List<TreasuryBill>>> getTreasuryBill({String token});
  Future<Result<List<CommercialPaper>>> getCommercialPaper({String token});
  Future<Result<List<FGNBond>>> getFGNBond({String token});
  Future<Result<List<PromissoryNote>>> getPromissoryNotes({String token});
  Future<Result<List<EuroBond>>> getEuroBond({String token});
  Future<Result<List<CorporateBond>>> getCorporateBond({String token});
  Future<Result<Fund>> getFundDetails({String token,
    String fundName, String fundId});
  Future<Result<Fund>> getFixedFundDetails({String token,
    String fixedIncomeId, String fixedIncomeName});
  Future<Result<Fund>> getTermFundDetails({String token,
    String termInstrumentId, String termInstrumentName});



}

class InvestmentService extends ABSInvestmentService{
  final dio = locator<Dio>();

  final microService = "zimvest.services.investment";
  @override
  Future<Result<List<InvestmentMutualFund>>> getMutualFundValuation({String token}) async{
    Result<List<InvestmentMutualFund>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Dashboards/mutualfundvaluation";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<InvestmentMutualFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
         types.add(InvestmentMutualFund.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      print("erroreeee ${e.response.data}");
      if(e.response.data is Map ){
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentFixedFund>>> getFixedFundValuation({String token}) async{
    Result<List<InvestmentFixedFund>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Dashboards/directfixedincomevaluation";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<InvestmentFixedFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
         types.add(InvestmentFixedFund.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response?.data  is Map ){
        print(e.response.data);

        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }
  @override
  Future<Result<List<InvestmentTermFund>>> getTermFundValuation({String token}) async{
    Result<List<InvestmentTermFund>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Dashboards/terminstrumentvaluation";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<InvestmentTermFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
         types.add(InvestmentTermFund.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response.data is Map ){
        print(e.response.data);
        result.errorMessage = e.response?.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentActivity>>> getMutualFundActivities({String token}) async{
    Result<List<InvestmentActivity>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards"
        "/mutualfundinvestmentactivities?StartDate=&EndDate=";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<InvestmentActivity> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentActivity.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response.data is Map ){
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentActivity>>> getFixedFundActivities({String token}) async{
    Result<List<InvestmentActivity>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards"
        "/fixedincomeinvestmentactivities?StartDate=&EndDate=";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<InvestmentActivity> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentActivity.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response.data is Map ){
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<InvestmentActivity>>> getTermFundActivities({String token}) async{
    Result<List<InvestmentActivity>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards/"
        "terminstrumentInvestmentactivities?StartDate=&EndDate=";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<InvestmentActivity> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(InvestmentActivity.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response.data is Map ){
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<MutualFund>>> getMoneyMarketFund({String token}) async{
    Result<List<MutualFund>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/"
        "api/MutualFunds/getmoneymarketfunds";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<MutualFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(MutualFund.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response is Map ){
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<MutualFund>>> getDollarFund({String token}) async{
    Result<List<MutualFund>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/MutualFunds/getdollarfunds";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<MutualFund> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(MutualFund.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }


  @override
  Future<Result<List<CommercialPaper>>> getCommercialPaper({String token})async {
    Result<List<CommercialPaper>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/CommercialPapers";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<CommercialPaper> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(CommercialPaper.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<CorporateBond>>> getCorporateBond({String token})async {
    Result<List<CorporateBond>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/CorporateBonds";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<CorporateBond> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(CorporateBond.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<EuroBond>>> getEuroBond({String token})async {
    Result<List<EuroBond>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/EuroBonds";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<EuroBond> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(EuroBond.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<FGNBond>>> getFGNBond({String token})async {
    Result<List<FGNBond>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/FGNBonds";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<FGNBond> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(FGNBond.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<PromissoryNote>>> getPromissoryNotes({String token}) async{
    Result<List<PromissoryNote>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/PromissoryNotes";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<PromissoryNote> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(PromissoryNote.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<TreasuryBill>>> getTreasuryBill({String token}) async{
    Result<List<TreasuryBill>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/TreasuryBills";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<TreasuryBill> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(TreasuryBill.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<TermInstrument>>> getDollarTermInstruments({String token}) async{
    Result<List<TermInstrument>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/ZimvestTermInstruments/getdollarterminstruments";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<TermInstrument> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(TermInstrument.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<TermInstrument>>> getNairaTermInstruments({String token}) async{
    Result<List<TermInstrument>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/ZimvestTermInstruments/getnairaterminstruments";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<TermInstrument> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(TermInstrument.fromJson(chaList));
        });
        result.data = channels;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Fund>> getFundDetails({String token, String fundName, String fundId}) async{
    Result<Fund> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Dashboards/managefund?FundId=$fundId&FundName=$fundName";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;


        result.data = Fund.fromJson(response1['data'] );
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<dynamic>>
  buyMoneyMarketFund({String token,
    int productId, double amount,
    int fundingChannel, int cardId,
    int directDebitFrequency,
    File documentFile})async {
    Result<dynamic> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    FormData body;
    if(fundingChannel == 1){

    body = FormData.fromMap({
      'ProductId':productId,
      'Amount':amount,
      'FundingChannel':fundingChannel,
      'CardId':cardId,
      'DirectDebitFrequency':directDebitFrequency,
    });
    }
    else if(fundingChannel == 2){
      Uint8List bytes;
      if(documentFile != null){
        bytes = await File(documentFile.path).readAsBytes();
        String base64Encode(List<int> bytes) => base64.encode(bytes);
      }

      body = FormData.fromMap({
        'ProductId':productId,
        'Amount':amount,
        'FundingChannel':fundingChannel,
        'DirectDebitFrequency':-1,
        "ProofOfPayment.DocumentFile": bytes == null ?'' :  base64Encode(bytes),
      });
    }


    var url = "${AppStrings.baseUrl}$microService/api/MutualFunds/buymoneymarketfund";
    print("url $url");
    print("body ${body.fields}");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        if(documentFile == null && fundingChannel == 2){
          result.data = BankPaymentDetails.fromJson(response1['data']);
        }

      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Fund>> getFixedFundDetails({String token, String fixedIncomeId,
    String fixedIncomeName}) async{
    Result<Fund> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Dashboards/managefixedincome?FixedIncomeId=$fixedIncomeId&FixedIncomeName=$fixedIncomeName";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;


        result.data = Fund.fromJson(response1['data'] );
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Fund>> getTermFundDetails({String token, String termInstrumentId,
    String termInstrumentName}) async{
    Result<Fund> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Dashboards/manageterminstrument?TermInstrumentId=$termInstrumentId&TermInstrumentName=$termInstrumentName";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;


        result.data = Fund.fromJson(response1['data'] );
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data['message'];
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }
}