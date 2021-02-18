class Bank{
  int id;
  String name;
  String code;
  String accountNum;
  String accountName;
  int accountId;
  bool isActive;

  Bank({this.id, this.code, this.name,
    this.accountNum, this.accountName,
    this.accountId, this.isActive});

  static Bank fromJson(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] ?? '',
      name: map['bankName'] ?? '',
      code: map['bankCode'] ?? '',
    );
  }

  static Bank fromJsonMain(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] ?? 0,
      name: map['bankName'] ?? '',
      accountName: map['accountName'] ?? '',
      accountNum: map['accountNumber'] ?? map['bankAccountNumer'] ?? '',
      isActive: map['isActive'] ?? false,
    );
  }
}