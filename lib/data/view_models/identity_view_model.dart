import 'package:flutter/foundation.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/data/services/identity_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSIdentityViewModel extends ChangeNotifier{
  User _user;

  User get user => _user;
  set user(User value);
  Future<Result<void>> login(String email, String password);
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

}