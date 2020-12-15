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

  @HiveField(5)
  bool isPinSetUp;

  User({this.fullname,
    this.expires,
    this.isRegistrationVerified,
    this.profileCode,
    this.token, this.isPinSetUp});

  static User fromJson(Map<String, dynamic> map) {
    return User(
      fullname: map['fullName'],
      isPinSetUp: map['isPinSetup'] ?? false,
      profileCode: map['profileCode'] ?? '',
      isRegistrationVerified: map['isRegistrationVerified'] ?? '',
      expires:map['expires'] == null ? DateTime.now().add(Duration(minutes: 30)):DateTime.fromMillisecondsSinceEpoch(map['expires'] * 1000),
      token: map['token']
    );
  }
}