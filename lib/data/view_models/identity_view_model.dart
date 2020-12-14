import 'package:flutter/foundation.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/completed_sections.dart';
import 'package:zimvest/data/models/individual/profile.dart';
import 'package:zimvest/data/models/savings/funding_channels.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/data/services/identity_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSIdentityViewModel extends ChangeNotifier{
  User _user;
  bool _isValidPassword = false;

  String email, password,firstName,lastName,phoneNumber,gender, verificationCode,pin;
  DateTime dob;
  String trackingId; int verificationId;

  User get user => _user;
  bool get isValidPassword => _isValidPassword;
  set user(User value);
  set isValidPassword(bool value);
  Future<Result<void>> login(String email, String password);
  Future<Result<bool>> emailAvailability(String email);
  Future<Result<bool>> phoneAvailability(String phone);
  Future<Result<void>> sendEmailOTP(String email);
  Future<Result<void>> resendEmailOTP({String trackingId, int verificationId});
  Future<Result<void>> confirmEmailOTP({String code});
  Future<Result<void>> setUpPin({String pin});
  Future<Result<CompletedSections>> checkCompletedSections({String token});
  Future<Result<void>> registerIndividual({
    String email, String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String referralCode, String dob
  });
  Future<Result<Profile>> getProfileDetail();
}

class IdentityViewModel extends ABSIdentityViewModel{
  ABSIdentityService _identityService = locator<ABSIdentityService>();
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();

  @override
  set user(User value) {
    _user = value;
    _localStorage.saveUserState(user);
    notifyListeners();
  }

  @override
  set isValidPassword(bool value) {
    _isValidPassword = value;
    notifyListeners();
  }

  IdentityViewModel(){
    _user = _localStorage.getUser();
  }

  @override
  Future<Result<void>> login(String email, String password)async {
    var result = Result<User>(error: false);
    try {
      result = await _identityService.login(email:email, password: password);
      if (result.error == false) {
        _localStorage.saveSecondaryState(SecondaryState(true));
        result.error = false;
        this.user = result.data;
      }
    } catch (e) {
      print("errorww ${e.toString()}");

          result.errorMessage = "An undefined Error happened.";


      result.error = true;
  }
  return result;
  }

  @override
  Future<Result<CompletedSections>> checkCompletedSections({String token}) {
    return _identityService.checkCompletedSections(token: token);
  }

  @override
  Future<Result<void>> registerIndividual({String email, String password, String firstName,  String dob,String lastName, String phoneNumber, String referralCode}) {
    return _identityService.registerIndividual(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      dob: dob
    );
  }

  @override
  Future<Result<Profile>> getProfileDetail() {
    return _identityService.getProfileDetail(
        token: user.token
    );
  }

  @override
  Future<Result<bool>> emailAvailability(String email) {
    return _identityService.emailAvailability(
         email
    );
  }

  @override
  Future<Result<bool>> phoneAvailability(String phone) {
    return _identityService.phoneAvailability(
    phone
    );
  }

  @override
  Future<Result<void>> confirmEmailOTP({ String code}) {
    return _identityService.confirmEmailOTP(
        code: code,
        verificationId: verificationId,
      trackingId: trackingId
    );
  }

  @override
  Future<Result<Map<String,dynamic>>> resendEmailOTP({String trackingId, int verificationId})async {
    var result = await _identityService.resendEmailOTP(
        verificationId: verificationId,
        trackingId: trackingId
    );

    if(result.error == false){
      verificationId = result.data['verificationId'];
      trackingId = result.data['trackingId'];
    }
    return result;
  }

  @override
  Future<Result<void>> sendEmailOTP(String email)async {
    var result = await _identityService.sendEmailOTP(
       email
    );

    if(result.error == false){
      verificationId = result.data['verificationId'];
      trackingId = result.data['trackingId'];
    }

    return result;
  }

  @override
  Future<Result<void>> setUpPin({String pin}) {
    return _identityService.setUpPin(
        pin: pin,token: user.token
    );
  }


}