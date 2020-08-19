import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/completed_sections.dart';
import 'package:zimvest/data/models/individual/profile.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSSettingsService{
  Future<Result<Profile>> getProfileDetail({String token});
  Future<Result<Kin>> getNextOfKin({String token});
  Future<Result<Notification>> getNotificationSettings({String token});
  Future<Result<Address>> getResidentialAddress({String token});
  Future<Result<String>> getBvn({String token});
  Future<Result<CompletedSections>> getCompletedSections({String token});
  Future<Result<void>> uploadIdentification({String token, File file, String id});
  Future<Result<void>> uploadUtilityBill({String token, File file});
  Future<Result<void>> updateResidentialAddress({String token, String address, int state});

}

class SettingsService extends ABSSettingsService{
  final dio = locator<Dio>();

  @override
  Future<Result<Profile>> getProfileDetail({String token}) async{
    Result<Profile> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = Profile.fromJson(response1['data']);
      }

    }on DioError catch(e){
      print("error $e");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Kin>> getNextOfKin({String token})async {
    Result<Kin> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/NextOfKins";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = Kin.fromJson(response1['data']);
      }

    }on DioError catch(e){
      print("error $e");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Notification>> getNotificationSettings({String token})async {
    Result<Notification> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles/notificationsettings";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = Notification.fromJson(response1['data']);
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> uploadIdentification({String token, File file, String id})async {
    Result<Notification> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Documents/identifications";

    var body = FormData.fromMap({
      "IdentificationNumber": id,

      "Identification.DocumentFile":await MultipartFile.fromFile(file.path)
    });

    print("lll $url");
    try{
      var response = await dio.post(url, options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> uploadUtilityBill({String token, File file})async {
    Result<void> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Documents/utilitybills";

    var body = FormData.fromMap({
      "UtilityBill.DocumentFile":await MultipartFile.fromFile(file.path)
    });

    print("lll $url");
    try{
      var response = await dio.post(url, options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> updateResidentialAddress({String token,
    String address, int state}) async{
    Result<void> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles/residentialinformation";

    var body = {
      "state":state,
      "residentialAddress":address
    };

    print("lll $url");
    try{
      var response = await dio.post(url, options: Options(headers: headers),data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Address>> getResidentialAddress({String token}) async{
    Result<Address> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api"
        "/Profiles/getresidentialinformation";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = Address.fromJson(response1['data']);
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<String>> getBvn({String token}) async{
    Result<String> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles/bvn";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = response1['data']['bvn'];
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<CompletedSections>> getCompletedSections({String token}) async{
    Result<CompletedSections> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/"
        "IndividualOnboarding/checkcompletedsections";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = CompletedSections.fromJson(response1['data']);
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

}