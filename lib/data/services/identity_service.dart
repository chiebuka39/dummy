import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zimvest/data/models/completed_sections.dart';
import 'package:zimvest/data/models/individual/profile.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

import 'account_settings_service.dart';

abstract class ABSIdentityService{
  Future<Result<User>> login({String email, String password});
  Future<Result<void>> registerIndividual({
    String email, String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String referralCode,
   String dob
  });
  Future<Result<void>> completePasswordReset({String userId,
    String token,
    String newPassword});
  Future<Result<void>> initiatePasswordReset({String email});
  Future<Result<CompletedSections>> checkCompletedSections({String token});
  Future<Result<Profile>> getProfileDetail({String token});
  Future<Result<bool>> emailAvailability(String email);
  Future<Result<void>> resetPassword(String email);
  Future<Result<void>> changePassword({String currentPassword, String newPassword, String token});
  Future<Result<bool>> phoneAvailability(String phone);
  Future<Result<void>> changePin({String currentPin,
    String newPin, String token});
  Future<Result<void>> setUpPin({String pin, String token});
  Future<Result<void>> resetPin({String pin, String token,String trackingId});
  Future<Result<Map<String,dynamic>>> sendEmailOTP(String email);
  Future<Result<Map<String,dynamic>>> initiatePinReset(String token);
  Future<Result<Map<String,dynamic>>> resendEmailOTP({String trackingId, int verificationId});
  Future<Result<Map<String,dynamic>>> resendPinResetCode({String trackingId, int verificationId,
    String token});
  Future<Result<void>> confirmEmailOTP({String trackingId, int verificationId, String code});
  Future<Result<void>> verifyPinResetCode({String trackingId, int verificationId, String code, String token});
  Future<Result<bool>> verifyPin({ String code, String token});
  Future<Result<void>> confirmEmail({String token, int userId});


}

class IdentityService extends ABSIdentityService {
  final dio = locator<Dio>();
  @override
  Future<Result<User>> login({String email, String password}) async{
    Result<User> result = Result(error: false);

    var body = {
      'email':email,
      'password':password
    };

    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/login";
    var url1 = "${AppStrings.baseUrl}api/Account/login";
    print("lll $body");
    print("lll $url");
    try{
      var response = await dio.post(url, data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        var user = User.fromJson(response1['data']);
        result.data = user;
      }

    }on DioError catch(e){
      print("error $e");
      print("ooop ${e.response.data}");
      result.error = true;
      if(e.response != null ){
        String message = e.response?.data['message'] ?? '';
        result.errorMessage = message;

      }

    }

    return result;
  }

  @override
  Future<Result<void>> completePasswordReset({String userId, String token, String newPassword}) {
    // TODO: implement completePasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> initiatePasswordReset({String email}) {
    // TODO: implement initiatePasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> confirmEmail({String token, int userId}) {
    // TODO: implement confirmEmail
    throw UnimplementedError();
  }



  @override
  Future<Result<void>> registerIndividual({String email, String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String referralCode, String dob}) async{

      Result<void> result = Result(error: false);

      var body = {
        'email':email,
        'password':password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": "+234$phoneNumber",
        'dateOfBirth':dob,
        'requestSource':'MOBILE'
      };


      var url = "${AppStrings.baseUrl}zimvest.onboarding.individual/api/IndividualOnboarding/registerindividual";
      print("body $body");
      print("url $url");
      try{
        var response = await dio.post(url, data: body);
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
        result.error = true;
        print("error ${e.toString()}");
        print("ooop ${e.response.data}");
        if(e.response != null ){
          print(e.response.data);

        }else{
          print(e.toString());
          result.errorMessage = "Sorry, We could not complete your request";
        }
      }

      return result;
  }

  @override
  Future<Result<CompletedSections>> checkCompletedSections({String token})async {
    Result<CompletedSections> result = Result(error: false);

    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/IndividualOnboarding/checkcompletedsections";

    print("lll $url");
    try{
      var response = await dio.get(url);
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
      print("error $e");
      result.error = true;
    }

    return result;
  }

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
  Future<Result<bool>> emailAvailability(String email) async{
    Result<bool> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/email-availability?Email=$email";

    print("lll $url");
    try{
      var response = await dio.get(url);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = response1['data']['isAvailable'];
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<bool>> phoneAvailability(String phone)async {
    Result<bool> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/"
        "phone-availability?PhoneNumber=${phone.length == 10 ? '0$phone':'$phone'}";

    print("lll $url");
    try{
      var response = await dio.get(url);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        result.data = response1['data']['isAvailable'];
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> confirmEmailOTP({String trackingId, int verificationId, String code}) async{
    Result<bool> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/confirm-email-otp";
    var body = {
      'trackingId': trackingId,
      'verificationId':verificationId,
      'code':code,

    };

    print("lll $url");
    print("lll $body");
    try{
      var response = await dio.post(url,data: body);
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
  Future<Result<void>> verifyPinResetCode({String trackingId, int verificationId, String code, String token}) async{
    Result<bool> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/verify-pin-reset-code";
    var body = {
      'trackingId': trackingId,
      'verificationId':verificationId,
      'code':code,

    };
    var headers = {"Authorization": "Bearer $token"};

    print("lll $url");
    print("lll $body");
    try{
      var response = await dio.post(url,data: body,options: Options(headers: headers));
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
  Future<Result<Map<String,dynamic>>> resendEmailOTP({String trackingId, int verificationId}) async{
    Result<Map<String,dynamic>> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/resend-email-otp";
    var body = {
      'trackingId': trackingId,
      'verificationId':verificationId
    };

    print("lll $url");
    try{
      var response = await dio.post(url,data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        Map<String,dynamic> data = Map();
        data['trackingId'] = response1['data']['trackingId'];
        data['verificationId'] = response1['data']['verificationId'];
        result.data = data;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }
  Future<Result<Map<String,dynamic>>> resendPinResetCode({String trackingId, int verificationId, String token}) async{
    Result<Map<String,dynamic>> result = Result(error: false);
    var headers = {"Authorization": "Bearer $token"};


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/resend-pin-reset-code";
    var body = {
      'trackingId': trackingId,
      'verificationId':verificationId
    };

    print("lll $url");
    try{
      var response = await dio.post(url,data: body,options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        Map<String,dynamic> data = Map();
        data['trackingId'] = response1['data']['trackingId'];
        data['verificationId'] = response1['data']['verificationId'];
        result.data = data;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<Map<String,dynamic>>> sendEmailOTP(String email)async {
    Result<Map<String,dynamic>> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/send-email-otp";
    var body = {
      'email': email
    };

    print("lll $url");
    try{
      var response = await dio.post(url,data: body);
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        Map<String,dynamic> data = Map();
        data['trackingId'] = response1['data']['trackingId'];
        data['verificationId'] = response1['data']['verificationId'];
        result.data = data;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }
  Future<Result<Map<String,dynamic>>> initiatePinReset(String token)async {
    Result<Map<String,dynamic>> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/initiate-pin-reset";
    var headers = {"Authorization": "Bearer $token"};

    print("lll $url");
    try{
      var response = await dio.post(url,data:{},options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        Map<String,dynamic> data = Map();
        data['trackingId'] = response1['data']['trackingId'];
        data['verificationId'] = response1['data']['verificationId'];
        result.data = data;
      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> setUpPin({String pin, String token})async {
    Result<void> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/setup-pin";
    var body = {
      'pin': pin
    };
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    print("lll $url");
    print("lll $body");
    print("lll $headers");
    try{
      var response = await dio.post(url,data: body, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        Map<String,dynamic> data = Map();

      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> resetPin({String pin, String token, String trackingId})async {
    Result<void> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/reset-pin";
    var body = {
      'newPin': pin,
      'trackingId': trackingId,
    };
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    print("lll $url");
    print("lll $body");
    print("lll $headers");
    try{
      var response = await dio.post(url,data: body, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        Map<String,dynamic> data = Map();

      }

    }on DioError catch(e){
      print("error ${e.response.data}");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> resetPassword(String email) async{
    Result<void> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/reset-password";
    var body = {
      'email': email
    };

    print("lll $url");
    print("lll $body");
    try{
      var response = await dio.post(url,data: body);
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
  Future<Result<void>> changePassword({String currentPassword,
    String newPassword, String token}) async{
    Result<void> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/changepassword";
    var body = {
      'currentPassword': currentPassword,
      'newPassword':newPassword,
      'confirmNewPassword':newPassword
    };

    var headers = {
      "Authorization":"Bearer $token"
    };

    print("lll $url");
    print("lll $body");
    print("lll $token");
    try{
      var response = await dio.post(url,data: body,options: Options(headers: headers));
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

      result.errorMessage = e?.response?.data['message'] ?? "An error occured";
    }

    return result;
  }

  @override
  Future<Result<void>> changePin({String currentPin,
    String newPin, String token}) async{
    Result<void> result = Result(error: false);


    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/change-pin";
    var body = {
      'currentPin': currentPin,
      'newPin':newPin,
    };

    var headers = {
      "Authorization":"Bearer $token"
    };

    print("lll $url");
    print("lll $body");
    print("lll $token");
    try{
      var response = await dio.post(url,data: body,options: Options(headers: headers));
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

      result.error = true;
print("loooo ${e.response.data}");
print("0oo9999 ${e.response.data.runtimeType}");
        if(e.response.data == null){
          result.errorMessage = "An error occured";
        }else{
          result.errorMessage = e.response.data.runtimeType == Map ? e.response.data['message']:"pppp";
        }
      print("lllll ${e.response?.data ?? 'false' is Map}");
    }

    return result;
  }

  @override
  Future<Result<bool>> verifyPin({String code, String token}) async{
    Result<bool> result = Result(error: false);

    var url = "${AppStrings.baseUrl}zimvest.services.identity/api/Account/verify-pin";
    var body = {
    'pin':code,
    };

    var headers = {
    "Authorization":"Bearer $token"
    };

    print("lll $url");
    print("lll $body");
    print("lll $token");
    try{
    var response = await dio.patch(url,data: body,options: Options(headers: headers));
    final int statusCode = response.statusCode;
    var response1 = response.data;
    print("iii ${response1}");
    print("iii------- ${response.statusCode}");

    if (statusCode != 200) {
    result.errorMessage = response1['message'];
    result.error = true;
    }else {
    result.error = false;
    result.data = true;

    }

    }on DioError catch(e){
    result.error = true;
    print("lllliiiccc ${e.response.statusCode}");
    print("lllliiiccc ${e.response.data}");
    if(e.response.statusCode == 405){



      result.errorMessage = "Pin Could not be verified";
    }else{
      print("1111 ${e.response.data}");
      result.errorMessage = e.response.data is Map ? e.response.data['message']:"Pin Could not be verified";
    }





    }

    return result;
  }

}