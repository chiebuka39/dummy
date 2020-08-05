import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/product_transaction.dart';
import 'package:zimvest/data/models/product_type.dart';
import 'package:zimvest/data/models/saving_plan.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSSavingService{
  Future<Result<List<ProductType>>> getProductTypes({String token});

  ///Get Customer's Savings information
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token});


  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token, int productId});

}

class SavingService extends ABSSavingService{
  final dio = locator<Dio>();
  @override
  Future<Result<List<ProductType>>> getProductTypes({String token}) async{
    Result<List<ProductType>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}zimvest.services.savings/api/Products/Types";
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
  Future<Result<List<ProductTransaction>>> getTransactionForProductType({String token,
    int productId}) async{
    Result<List<ProductTransaction>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}zimvest.services.savings/api/Savings"
        "/Customers/Transactions?ProductTypeId=$productId";
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
        (response1['data'] as List).forEach((chaList) {
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
  Future<Result<List<SavingPlanModel>>> getSavingPlans({String token}) async{
    Result<List<SavingPlanModel>> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };


    var url = "${AppStrings.baseUrl}zimvest.services.savings/api/Savings/Customers";
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
        List<SavingPlanModel> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(SavingPlanModel.fromJson(chaList));
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
}