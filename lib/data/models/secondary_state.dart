import 'package:hive/hive.dart';

part 'secondary_state.g.dart';

@HiveType(typeId: 2)
class SecondaryState extends HiveObject{

  @HiveField(0)
  bool isLoggedIn = false;

  @HiveField(1)
  DateTime lastMinimized;

  @HiveField(2)
  String password;

  @HiveField(3)
  String email;

  SecondaryState(this.isLoggedIn,{this.lastMinimized, this.password, this.email});
}