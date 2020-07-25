import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User{

  @HiveField(0)
  String fullname;

  @HiveField(1)
  String token;

  @HiveField(2)
  String isRegistrationVerified;

  @HiveField(3)
  String profileCode;

  @HiveField(4)
  DateTime expires;

  User({this.fullname,
    this.expires,
    this.isRegistrationVerified,
    this.profileCode,
    this.token});

  static User fromJson(Map<String, dynamic> map) {
    return User(
      fullname: map['fullName'],
      profileCode: map['profileCode'] ?? '',
      isRegistrationVerified: map['isRegistrationVerified'] ?? '',
      expires: DateTime.now(),
      token: map['token']
    );
  }
}