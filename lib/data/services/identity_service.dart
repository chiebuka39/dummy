import 'package:dio/dio.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSIdentityService{
  Future<Result<User>> login({String email, String password});
  Future<Result<void>> registerIndividual({
    String email, String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String referralCode
  });
  Future<Result<void>> completePasswordReset({String userId,
    String token,
    String newPassword});
  Future<Result<void>> initiatePasswordReset({String email});
  Future<Result<void>> confirmEmail({String token, int userId});
  Future<Result<void>> changePassword({String currentPassword, String newPassword, String confirmPassword});

}

class IdentityService extends ABSIdentityService{
  final dio = locator<Dio>();
  @override
  Future<Result<User>> login({String email, String password}) async{
    Result<User> result = Result(error: false);

    var body = {
      'email':email,
      'password':password
    };

    var url = "";
    try{
      var response = await dio.post(url, data: body);

    }on DioError catch(e){
      result.error = true;
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
  Future<Result<void>> changePassword({String currentPassword, String newPassword, String confirmPassword}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> registerIndividual({String email, String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String referralCode}) async{

      Result<User> result = Result(error: false);

      var body = {
        'email':email,
        'password':password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      };

      var url = "";
      try{
        var response = await dio.post(url, data: body);

      }on DioError catch(e){
        result.error = true;
      }

      return result;
  }

}