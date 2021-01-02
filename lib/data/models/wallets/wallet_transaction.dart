class WalletsTransaction {
  bool status;
  String message;
  List<TransactionsData> transactionsData;

  WalletsTransaction({this.status, this.message, this.transactionsData});

  WalletsTransaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      transactionsData = new List<TransactionsData>();
      json['data'].forEach((v) {
        transactionsData.add(new TransactionsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.transactionsData != null) {
      data['data'] = this.transactionsData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionsData {
  int amount;
  int walletBalance;
  String currency;
  String movementType;
  String transactionReference;
  String paymentReference;
  String narration;
  String transactionStatus;
  String date;
  String dateFilter;

  TransactionsData(
      {this.amount,
      this.walletBalance,
      this.currency,
      this.movementType,
      this.transactionReference,
      this.paymentReference,
      this.narration,
      this.transactionStatus,
      this.date,
      this.dateFilter});

  TransactionsData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    walletBalance = json['walletBalance'];
    currency = json['currency'];
    movementType = json['movementType'];
    transactionReference = json['transactionReference'];
    paymentReference = json['paymentReference'];
    narration = json['narration'];
    transactionStatus = json['transactionStatus'];
    date = json['date'];
    dateFilter = json['dateFilter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['walletBalance'] = this.walletBalance;
    data['currency'] = this.currency;
    data['movementType'] = this.movementType;
    data['transactionReference'] = this.transactionReference;
    data['paymentReference'] = this.paymentReference;
    data['narration'] = this.narration;
    data['transactionStatus'] = this.transactionStatus;
    data['date'] = this.date;
    data['dateFilter'] = this.dateFilter;
    return data;
  }
}
