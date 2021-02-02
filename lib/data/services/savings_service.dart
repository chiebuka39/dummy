import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/product_type.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/savings/aspire_target.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/savings/savings_frequency.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/main.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSSavingService{
  Future<Result<List<ProductType>>> getProductTypes({String token});

  Future<Result<void>> pauseSaving({String token,int savingModelId});
  Future<Result<void>> continueSaving({String token,int savingModelId});
  Future<Result<void>> withdrawFund({String token,int customerSavingId,
    double amount, int customerBankId, String pin,int withdrawalChannel});

  ///Get Customer's Savings information
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token});

  Future<Result<SavingPlanModel>> createWealthBox({String token,
    int cardId,
    int frequency,
    int fundingChannel,
    double savingsAmount,
    DateTime startDate,
  });

  Future<Result<List<SavingsFrequency>>> getSavingFrequency({String token});
  Future<Result<List<FundingChannel>>> getFundingChannel({String token});
  Future<Result<List<FundingChannel>>> getWithdrawalChannel({String token});
  Future<Result<List<ProductTransaction>>> getTransactionForProduct({String token,
    int id});
  Future<Result<AspireTarget>> calculateTargetSavings({
    String token,
    double bulkSum,
    int frequency,
    bool isBulkSum,
    DateTime maturityDate,
    double targetAmount,
  });

  Future<Result<SavingPlanModel>> createTargetSavings({int cardId,
    int fundingChannel, int frequency, String planName, DateTime maturityDate,
    DateTime startDate, int productId, double targetAmount, bool autoSave,
    int savingsAmount, String token});
  Future<Result<SavingPlanModel>> createTargetSavings2({int cardId,
    int fundingChannel, int frequency, String planName, DateTime maturityDate,
    DateTime startDate, int productId, double targetAmount, bool autoSave,
    int savingsAmount, String token, File image});


  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token, int productId});
  Future<Result<void>> topUp({String token,
    int cardId, int custSavingId, int fundingChannel,
    double savingsAmount});
  Future<Result<List<ProductTransaction>>> getSavingsTopup({String token});
  Future<Result<List<ProductTransaction>>> getSavingsWithdrawal({String token});
  Future<Result<Map>> getWithdrawalSummary({String token, int productId});
  Future<Result<void>> terminateSavings({String token, int productId});
}

class SavingService extends ABSSavingService{
  final dio = locator<Dio>();
  @override
  Future<Result<List<ProductType>>> getProductTypes({String token}) async{
    Result<List<ProductType>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Products/Types";
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
        List<ProductType> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
         types.add(ProductType.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.error.runtimeType == SocketException){
        result.error = true;
        result.networkAvailable = false;
        result.errorMessage =  "Sorry, We could not complete your request";
        return result;
      }
      if(e.response != null ){
        print(e.response.data);
        result.errorMessage =  "Sorry, We could not complete your request";
      }else{
        print(e.toString());
        result.errorMessage = e.response.data['message'];
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token,
    int productId}) async{
    Result<List<ProductTransaction>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Savings"
        "/Customers/Transactions?productId=$productId";
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
        List<ProductTransaction> types = [];
        (response1['data']['result'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(ProductTransaction.fromJson(chaList));
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
  Future<Result<List<ProductTransaction>>> getSavingsTopup({String token}) async{
    Result<List<ProductTransaction>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Savings"
        "/Customers/Transactions?TransactionType=1";
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
        List<ProductTransaction> types = [];
        (response1['data']["result"] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(ProductTransaction.fromJson(chaList));
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
  Future<Result<List<ProductTransaction>>> getSavingsWithdrawal({String token}) async{
    Result<List<ProductTransaction>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Savings"
        "/Customers/Transactions?TransactionType=2";
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
        List<ProductTransaction> types = [];
        (response1['data']["result"] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(ProductTransaction.fromJson(chaList));
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
  Future<Result<List<ProductTransaction>>> getTransactionForProduct({String token,
    int id}) async{
    Result<List<ProductTransaction>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Savings"
        "/Customers/$id/Transactions";
    print("url $url");
    try{
      var response = await dio.get(url,options: Options(headers: headers,receiveTimeout: 3000,
          sendTimeout: 300));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>");
      print("iii ${response1}");
      print("<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<ProductTransaction> types = [];
        print("pppppppgggg ${response1['data'].runtimeType}");
        (response1['data']["result"] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(ProductTransaction.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      if(e.error.runtimeType == SocketException){
        result.error = true;
        result.networkAvailable = false;
        result.errorMessage = "Sorry, We could not complete your request";
        print("ppp[[[[[[");
        return result;
      }
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        //result.errorMessage = e.response.data;
        print("j<<<<<<<<<<<<<<<< ${e.response.data}");
      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token}) async{
    Result<List<SavingPlanModel>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Savings/Customers";
    print("url $url");
    print("url $headers");
    try{
      var response = await dio.get(url,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;


      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        List<SavingPlanModel> types = [];
        (response1['data'] as List).forEach((chaList) {
          print("kk $chaList");
          types.add(SavingPlanModel.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      if(e.error.runtimeType == SocketException){
        print("<<<<<<<<<");
        result.networkAvailable = false;
        result.errorMessage = "Failed to connect, "
            "please connect to the internet and try again";

      }else{
        print("error000 ${e.response}");

        if(e.response != null ){
          print(e.response.data);
          //result.errorMessage = e.response.data['message'];
        }else{
          print(e.toString());
          result.errorMessage = "Sorry, We could not complete your request";
        }
        result.error = true;
      }

    }

    return result;
  }

  @override
  Future<Result<List<SavingsFrequency>>> getSavingFrequency({String token})async {
    Result<List<SavingsFrequency>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Products/Frequencies";
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


    var url = "zimvest.services.savings/api/Products/FundingChannels";
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
  Future<Result<List<FundingChannel>>> getWithdrawalChannel({String token})async {
    Result<List<FundingChannel>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "zimvest.services.savings/api/Products/WithdrawalChannels";
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
    int cardId, int frequency, int fundingChannel,
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


    var url = "zimvest.services.savings/api/v2/Savings/ZimvestSavings";
    print("url $url");
    print("body $body");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else if( statusCode == 201){
        result.error = false;
        result.data = SavingPlanModel.fromJson(response1['data']);
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
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
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Your savings was not successful";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> topUp({String token,
    int cardId, int custSavingId, int fundingChannel,
    double savingsAmount}) async{
    Result<void> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      "cardId": cardId,
      "customerSavingId": custSavingId,
      "fundingChannel": fundingChannel,
      "amount": savingsAmount,
    };


    var url = "zimvest.services.savings/api/v2/Savings/Topup";
    print("url $url");
    print("body $body");
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

        //result.data = SavingPlanModel.fromJson(response1['data']);
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data is Map){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<AspireTarget>> calculateTargetSavings({String token,
    double bulkSum, int frequency,
    DateTime maturityDate, double targetAmount,bool isBulkSum})async {
    Result<AspireTarget> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      "bulkSum": bulkSum,
      "frequency": frequency,
      "isBulkSum": isBulkSum,
      "maturityDate": maturityDate.toIso8601String(),
      "targetAmount": targetAmount,
    };


    var url = "zimvest.services.savings/api/Savings/Calculations/TargetSavings";
    print("url $url");
    print("body $body");
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
        result.data = AspireTarget.fromJson(response1['data']);
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }
    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<SavingPlanModel>> createTargetSavings({int cardId,
    int fundingChannel, int frequency, String planName, DateTime maturityDate,
    DateTime startDate, int productId, double targetAmount,bool autoSave,
    int savingsAmount, String token}) async{
    Result<SavingPlanModel> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      "cardId": cardId,
      'isAutoSave':autoSave,
      "frequency": frequency,
      "fundingChannel": fundingChannel,
      "maturityDate": maturityDate.toIso8601String(),
      "startDate": startDate.toIso8601String(),
      "targetAmount": targetAmount,
      "productId": productId,
      "planName": planName,
      "savingsAmount": savingsAmount,
    };


    var url = "zimvest.services.savings/api/v2/Savings/TargetSavings";
    print("url $url");
    print("body $body");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");
      print("111i ${statusCode}");

      if (statusCode != 200 && statusCode != 201) {
        print("oooooooogggggggggggg");
        result.errorMessage = response1['message'];
        result.error = true;
      }
      else {
        print("33333333333333oooooooo");
        result.error = false;
        //result.data = SavingPlanModel.fromJson(response1['data']);
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }

    }on DioError catch(e){
      print("errrrrrrrr");
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<SavingPlanModel>> createTargetSavings2({int cardId,
    int fundingChannel, int frequency, String planName, DateTime maturityDate,
    DateTime startDate, int productId, double targetAmount,bool autoSave,
    int savingsAmount, String token, File image}) async{
    Result<SavingPlanModel> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = image == null ?{
      "cardId": cardId,
      'isAutoSave':autoSave,
      "frequency": frequency,
      "fundingChannel": fundingChannel,
      "maturityDate": maturityDate.toIso8601String(),
      "startDate": startDate.toIso8601String(),
      "targetAmount": targetAmount,
      "productId": productId,
      "planName": planName,
      "savingsAmount": savingsAmount,
    } : FormData.fromMap({
      "cardId": cardId,
      'isAutoSave':autoSave,
      "frequency": frequency,
      "fundingChannel": fundingChannel,
      "maturityDate": maturityDate.toIso8601String(),
      "startDate": startDate.toIso8601String(),
      "targetAmount": targetAmount,
      "productId": productId,
      "planName": planName,
      "savingsAmount": savingsAmount,
      "PhotoFile": await MultipartFile.fromFile(image.path),
    });


    var url = image == null ?"zimvest.services.savings/api/v2/Savings/TargetSavings":
    "zimvest.services.savings/api/v2/Savings/TargetSavingsForm";
    print("url $url");
    print("body $body");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");
      print("111i ${statusCode}");

      if (statusCode != 200 && statusCode != 201) {
        print("oooooooogggggggggggg");
        result.errorMessage = response1['message'];
        result.error = true;
      }
      else {
        print("33333333333333oooooooo");
        result.error = false;
        //result.data = SavingPlanModel.fromJson(response1['data']);
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }

    }on DioError catch(e){
      print("errrrrrrrr ${e.response.data}");
      print("error $e}");

      if(e.response != null ){
        if(e.response.data is String){
          result.errorMessage = "Sorry, We could not complete your request";
        }
        else{
          print(e.toString());

          result.errorMessage = e.response.data['message'];
        }


      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not create your target savings";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> continueSaving({String token, int savingModelId}) async{
    Result<void> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      "id": savingModelId,
    };


    var url = "zimvest.services.savings/api/Savings/Continue";
    print("url $url");
    print("body $body");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else if( statusCode == 201){
        result.error = true;
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }
      else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> pauseSaving({String token, int savingModelId}) async{
    Result<void> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      "id": savingModelId,
    };


    var url = "zimvest.services.savings/api/Savings/Pause";
    print("url $url");
    print("body $body");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else if( statusCode == 201){
        result.error = true;
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }
      else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> withdrawFund({String token, int customerSavingId,
    double amount, int customerBankId, String pin,int withdrawalChannel}) async{
    Result<void> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var body = {
      'withdrawalChannel':withdrawalChannel,
      "customerSavingId": customerSavingId,
      "amount": amount,
      "customerBankId": customerBankId,
      "pin": pin,
      'requestChannel':2
    };


    var url = "zimvest.services.savings/api/v2/Savings/Withdrawals";
    print("url $url");
    print("body $body");
    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else if( statusCode == 201){
        result.error = true;
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }
      else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Map>> getWithdrawalSummary({String token, int productId}) async{
    Result<Map> result = Result(error: false);
    Map<String, dynamic> res = Map();


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };



    var url = "zimvest.services.savings/api/Savings/Calculations/WithdrawalSummary/$productId";
    print("url $url");

    try{
      var response = await dio.get(url,options: Options(headers: headers),);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else if( statusCode == 201){
        result.error = true;
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }
      else {
        result.error = false;
        res['charge']= response1['data']['withdrawalCharge'];
        res['amount'] =response1['data']['withdrawableAmount'];
        res['prompt'] =response1['data']['promptMessage'];
        result.data = res;



      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> terminateSavings({String token, int productId}) async{
    Result<void> result = Result(error: false);



    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var body = {
      "savingsId" : productId
    };



    var url = "zimvest.services.savings/api/Savings/TargetSavings/Terminate";
    print("url $url");

    try{
      var response = await dio.post(url,options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else if( statusCode == 201){
        result.error = true;
        if(response1['message'] != null){
          result.errorMessage = response1['message'];
        }
      }
      else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error $e}");
      if(e.response != null ){
        print(e.response.data);
        if(e.response.data['message'] is String){
          result.errorMessage = e.response.data['message'];
        }

      }else{
        print(e.toString());
        result.errorMessage = "Sorry, We could not complete your request";
      }
      result.error = true;
    }

    return result;
  }
}