import 'package:flutter/foundation.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSIdentityViewModel extends ChangeNotifier{
  Future<Result<void>> login(String email, String password);
}

class IdentityViewModel extends ABSIdentityViewModel{
  @override
  Future<Result<void>> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

}