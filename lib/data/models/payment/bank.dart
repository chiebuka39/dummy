class Bank{
  int id;
  String name;
  String code;

  Bank({this.id, this.code, this.name});

  static Bank fromJson(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] ?? '',
      name: map['bankName'] ?? '',
      code: map['bankCode'] ?? '',
    );
  }
}