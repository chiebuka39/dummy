import 'package:dio/dio.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/models/payment/bank.dart';
import 'package:zimvest/data/models/payment/card.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSPaymentService {
  Future<Result<List<Bank>>> getBanks(String token);
  Future<Result<List<PaymentCard>>> getUserCards(String token);
  Future<Result<void>> deleteBank(String token,int bankId);
  Future<Result<void>> setBankAsActive(String token,int bankId);
  Future<Result<List<Bank>>> getCustomerBank(String token);
  Future<Result<Bank>> addBank(
      {String token,
      int bankId,
      String bankName,
      String accountName,
      String accountNum});
  Future<Result<List<String>>> validateBank(
      {String token, int customerId, String accountNum, String bankCode});
}

class PaymentService extends ABSPaymentService {
  final dio = locator<Dio>();
  @override
  Future<Result<List<Bank>>> getBanks(String token) async {
    Result<List<Bank>> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};

    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/Banks";

    //print("lll $url");
    try {
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      //print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<Bank> banks = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          banks.add(Bank.fromJson(chaList));
        });
        result.data = banks;
      }
    } on DioError catch (e) {
      print("error $e");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Bank>> addBank(
      {String token,
      int bankId,
      String bankName,
      String accountName,
      String accountNum}) async {
    Result<Bank> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};
    var body = {
      "bankId": bankId,
      "bankName": bankName,
      "accountNumber": accountNum,
      "accountName": accountName,
    };

    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/"
        "banks";

//    print("lll $url");
//    print("lll $body");
    try {
      var response = await dio.post(url, options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      //print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;

        result.data = Bank.fromJsonMain(response1['data']);
      }
    } on DioError catch (e) {
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
  Future<Result<List<Bank>>> getCustomerBank(String token) async{
    Result<List<Bank>> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};


    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/Banks/customers";

    //print("lll $url");
    try {
      var response = await dio.get(url,
          options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      //print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<Bank> banks = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          banks.add(Bank.fromJsonMain(chaList));
        });
        result.data = banks;
      }
    } on DioError catch (e) {
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
  Future<Result<List<String>>> validateBank(
      {String token,
      int customerId,
      String accountNum,
      String bankCode}) async {
    Result<List<String>> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};

    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/"
        "banks/v2/validations?BankCode=$bankCode&AccountNumber=$accountNum";

    print("lll $url");
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
        List<String> data = ["", ""];
        data[0] = response1['data']['accountName'];
        data[1] = response1['data']['accountNumber'];
        result.data = data;
      }
    } on DioError catch (e) {
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
  Future<Result<void>> deleteBank(String token, int bankId)async {
    Result<void> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};


    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/"
        "Banks/$bankId";

    print("lll $url");
    try {
      var response = await dio.delete(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;

      }
    } on DioError catch (e) {
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
  Future<Result<void>> setBankAsActive(String token, int bankId)async {
    Result<void> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};


    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/"
        "Banks/$bankId";

    print("lll $url");
    try {
      var response = await dio.patch(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;

      }
    } on DioError catch (e) {
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
  Future<Result<List<PaymentCard>>> getUserCards(String token)async {
    Result<List<PaymentCard>> result = Result(error: false);

    var headers = {"Authorization": "Bearer $token"};


    var url = "${AppStrings.baseUrl}zimvest.services.payment/api/Cards";

    //print("lll $url");
    try {
      var response = await dio.get(url,
          options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      //print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      } else {
        result.error = false;
        List<PaymentCard> cards = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          cards.add(PaymentCard.fromJson(chaList));
        });
        result.data = cards;
      }
    } on DioError catch (e) {
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
