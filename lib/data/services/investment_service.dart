import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/investment/investment_fixed_fund.dart';
import 'package:zimvest/data/models/investment/investment_fund_model.dart';
import 'package:zimvest/data/models/investment/investment_termed_fund.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/product_type.dart';
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
  Future<Result<List<SavingsFrequency>>> getSavingFrequency({String token})async {
    Result<List<SavingsFrequency>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Products/Frequencies";
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
        List<SavingsFrequency> freq = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          freq.add(SavingsFrequency.fromJson(chaList));
        });
        result.data = freq;
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
  Future<Result<List<FundingChannel>>> getFundingChannel({String token})async {
    Result<List<FundingChannel>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}$microService/api/Products/FundingChannels";
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
        List<FundingChannel> channels = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          channels.add(FundingChannel.fromJson(chaList));
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
  Future<Result<SavingPlanModel>> createWealthBox({String token,
    String cardId, int frequency, int fundingChannel,
    double savingsAmount, DateTime startDate}) async{
    Result<SavingPlanModel> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      "cardId": cardId,
      "frequency": frequency,
      "fundingChannel": fundingChannel,
      "savingsAmount": savingsAmount,
      "startDate": startDate.toIso8601String()
    };


    var url = "${AppStrings.baseUrl}$microService/api/v2/Savings/ZimvestSavings";
    print("url $url");
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

        result.data = SavingPlanModel.fromJson(response1['data']);
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
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
}