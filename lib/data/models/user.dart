class User{
  String fullname;
  String token;
  String isRegistrationVerified;
  String profileCode;
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