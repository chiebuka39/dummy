import 'package:hive/hive.dart';
import 'package:zimvest/data/models/secondary_state.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSStateLocalStorage {

  void initBox();

  void saveSecondaryState(SecondaryState secondaryState);

  void saveUserState(User user);

  SecondaryState getSecondaryState();

  User getUser();
}

class StateBoxStorage extends ABSStateLocalStorage{
  Box box;
  @override
  void initBox() {
    box = Hive.box(AppStrings.state);
  }

  StateBoxStorage(){
    initBox();
  }

  @override
  void saveUserState(User user) {
    box.put('user', user);
  }

  @override
  void saveSecondaryState(SecondaryState secondaryState) {
    box.put('state', secondaryState);
  }

  @override
  User getUser() {

    return box.get('user', defaultValue: null);
  }

  @override
  SecondaryState getSecondaryState() {

    return box.get('state', defaultValue: SecondaryState(false));
  }



}