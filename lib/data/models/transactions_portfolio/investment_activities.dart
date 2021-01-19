class InvestmentActivities {
  Activities activities;

  InvestmentActivities({this.activities});

  InvestmentActivities.fromJson(Map<String, dynamic> json) {
    activities = json['data'] != null
        ? new Activities.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['data'] = this.activities.toJson();
    }
    return data;
  }
}

class Activities {
  List<TransactionData> transactionData;
  String dateJoined;
  String averageYield;
  String instrumentName;
  String balance;
  int currentValue;
  bool isMatured;
  String maturityDate;

  Activities(
      {this.transactionData,
      this.dateJoined,
      this.averageYield,
      this.instrumentName,
      this.balance,
      this.currentValue,
      this.isMatured,
      this.maturityDate});

  Activities.fromJson(Map<String, dynamic> json) {
    if (json['transactionData'] != null) {
      transactionData = new List<TransactionData>();
      json['transactionData'].forEach((v) {
        transactionData.add(new TransactionData.fromJson(v));
      });
    }
    dateJoined = json['dateJoined'];
    averageYield = json['averageYield'];
    instrumentName = json['instrumentName'];
    balance = json['balance'];
    currentValue = json['currentValue'];
    isMatured = json['isMatured'];
    maturityDate = json['maturityDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactionData != null) {
      data['transactionData'] =
          this.transactionData.map((v) => v.toJson()).toList();
    }
    data['dateJoined'] = this.dateJoined;
    data['averageYield'] = this.averageYield;
    data['instrumentName'] = this.instrumentName;
    data['balance'] = this.balance;
    data['currentValue'] = this.currentValue;
    data['isMatured'] = this.isMatured;
    data['maturityDate'] = this.maturityDate;
    return data;
  }
}

class TransactionData {
  String date;
  String currency;
  String amount;
  String status;
  String description;
  String startDate;
  int transactionId;
  int expectedWithdrawalAmount;

  TransactionData(
      {this.date,
      this.currency,
      this.amount,
      this.status,
      this.description,
      this.startDate,
      this.transactionId,
      this.expectedWithdrawalAmount});

  TransactionData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    currency = json['currency'];
    amount = json['amount'];
    status = json['status'];
    description = json['description'];
    startDate = json['startDate'];
    transactionId = json['transactionId'];
    expectedWithdrawalAmount = json['expectedWithdrawalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['transactionId'] = this.transactionId;
    data['expectedWithdrawalAmount'] = this.expectedWithdrawalAmount;
    return data;
  }
}