import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
  Future<Result<void>> updateNotoficationSettings({String token,
    bool receiveEmailUpdateOnInvestment,
    bool receiveEmailUpdateOnSavings, bool subscribeToNewsLetter});
  Future<Result<void>> uploadUtilityBill({String token, File file});
  Future<Result<void>> updateResidentialAddress({String token, String address, int state});
  Future<Result<void>> updateBvn({String token, String bvn});
  Future<Result<void>> updateKin({
    String token,
    String fullName,
    int relationship,
    String email,
    String phoneNumber,
  });
  Future<Result<void>> profileInvestor({String token, String firstName,
    int investmentKnowledge, int mostConernedDuringInvestment,
    int instrumentCurrentlyOwned, int marketAndParticularStockDrops,
    int hypotheticalInvestmentPlan, int investmentDurationBeforeWithdrawal,
    int durationToCompletelyWithdraw,
    bool ethicalConsideration, String email, String lastName});
  Future<Result<void>> updateProfile({
    String token,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String dOB,
    int gender,
    int maritalStatus,
    File profile
  });

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
      print("000000kkk ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = Profile.fromJson(response1['data']);
      }

    }on DioError catch(e){
      print("error $e");
      print("errorrrrr ${e.response.data}");
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
        if(response1['data'] == null){
          result.data = Kin(fullName: "",
              relationship: "Aunty",phoneNumber: "",customerId: 0000, email: "");
        }else{
          result.data = Kin.fromJson(response1['data']);
        }

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
        if(response1['data'] == null){
          result.data = Notification();
        }else{
          result.data = Notification.fromJson(response1['data']);
        }

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
    print("lll $headers");
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
      print("error ${e.response?.data}");
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
        if(response1['data'] == null){
          result.data = "";
        }else{
          result.data = response1['data']['bvn'];
        }

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

  @override
  Future<Result<void>> updateNotoficationSettings({String token,
    bool receiveEmailUpdateOnInvestment,
    bool receiveEmailUpdateOnSavings,
    bool subscribeToNewsLetter}) async{
    Result<void> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles/notificationsettings";

    var body = {
      "receiveEmailUpdateOnInvestment":receiveEmailUpdateOnInvestment,
      "receiveEmailUpdateOnSavings":receiveEmailUpdateOnSavings,
      "subscribeToNewsLetter":subscribeToNewsLetter
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
  Future<Result<void>> updateBvn({String token, String bvn})async {
    Result<void> result = Result(error: false);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles/bvn";

    var body = {
      "bvn":bvn,
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
  Future<Result<void>> updateProfile({String token, String firstName,
    String lastName, String email, String phoneNumber,
    String dOB, int gender, int maritalStatus, File profile}) async{
    Result<void> result = Result(error: false);
    Uint8List base64Decode(String source) => base64.decode(source);

    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/Profiles";

    var body = FormData.fromMap({
      "FirstName":firstName,
      "LastName":lastName,
      "PhoneNumber":phoneNumber,
      "Email":email,
      "Gender":gender,
      "DOB":dOB,
      "MaritalStatus":maritalStatus,
      "Form": await MultipartFile.fromFile(profile.path),
    });

    print("lll $url");
    print("lll ${body.fields}");
    try{
      var response = await dio.patch(url, options: Options(headers: headers),data: body);
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
  Future<Result<void>> updateKin({String token, String fullName,
    int relationship, String email, String phoneNumber}) async{
    Result<void> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/NextOfKins";

    var body = {
      "fullName":fullName,
      "relationship":relationship,
      "email":email,
      "phoneNumber":phoneNumber,

    };


    print("lll $url");
    print("lll $body");
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
      print("error22 $e");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> profileInvestor({String token,
    String firstName, int investmentKnowledge,
    int mostConernedDuringInvestment, int instrumentCurrentlyOwned,
    int marketAndParticularStockDrops, int hypotheticalInvestmentPlan,
    int investmentDurationBeforeWithdrawal, int durationToCompletelyWithdraw,
    bool ethicalConsideration, String email, String lastName}) async{
    Result<void> result = Result(error: false);


    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/NextOfKins";

    var body = {
      "investmentKnowledge":investmentKnowledge,
      "lastName":lastName,
      "emailAddress":email,
      "firstName":firstName,
      "mostConernedDuringInvestment":mostConernedDuringInvestment,
      "instrumentCurrentlyOwned":instrumentCurrentlyOwned,
      "marketAndParticularStockDrops":marketAndParticularStockDrops,
      "hypotheticalInvestmentPlan":hypotheticalInvestmentPlan,
      "investmentDurationBeforeWithdrawal":investmentDurationBeforeWithdrawal,
      "durationToCompletelyWithdraw":durationToCompletelyWithdraw,
      "ethicalConsideration":ethicalConsideration,



    };


    print("lll $url");
    print("lll $body");
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
      print("error22 $e");
      result.error = true;
    }

    return result;
  }

}