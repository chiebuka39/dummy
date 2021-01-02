class Wallets {
  bool status;
  String message;
  List<WalletData> walletData;

  Wallets({this.status, this.message, this.walletData});

  Wallets.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      walletData = new List<WalletData>();
      json['data'].forEach((v) {
        walletData.add(new WalletData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.walletData != null) {
      data['data'] = this.walletData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletData {
  int walletId;
  String currency;
  String walletNumber;
  int walletBalance;

  WalletData(
      {this.walletId, this.currency, this.walletNumber, this.walletBalance});

  WalletData.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    currency = json['currency'];
    walletNumber = json['walletNumber'];
    walletBalance = json['walletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['walletId'] = this.walletId;
    data['currency'] = this.currency;
    data['walletNumber'] = this.walletNumber;
    data['walletBalance'] = this.walletBalance;
    return data;
  }
}