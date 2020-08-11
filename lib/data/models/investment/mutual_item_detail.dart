class Fund {
  Fund({
    this.transactionFund,
    this.dateJoined,
    this.averageYield,
    this.accruedInterest,
    this.currentMarketBalance,
    this.instrumentName,
    this.balance,
    this.currentValue,
  });

  List<TransactionDatum> transactionFund;
  String dateJoined;
  String averageYield;
  String accruedInterest;
  String currentMarketBalance;
  String instrumentName;
  String balance;
  double currentValue;

  factory Fund.fromJson(Map<String, dynamic> json) => Fund(
    transactionFund: List<TransactionDatum>.from(json["transactionData"].map((x) => TransactionDatum.fromJson(x))),
    dateJoined: json["dateJoined"],
    averageYield: json["averageYield"],
    accruedInterest: json["accruedInterest"],
    currentMarketBalance: json["currentMarketBalance"],
    instrumentName: json["instrumentName"],
    balance: json["balance"],
    currentValue: json["currentValue"],
  );

  Map<String, dynamic> toJson() => {
    "transactionFund": List<dynamic>.from(transactionFund.map((x) => x.toJson())),
    "dateJoined": dateJoined,
    "averageYield": averageYield,
    "accruedInterest": accruedInterest,
    "currentMarketBalance": currentMarketBalance,
    "instrumentName": instrumentName,
    "balance": balance,
    "currentValue": currentValue,
  };
}

class TransactionDatum {
  TransactionDatum({
    this.transactionId,
    this.date,
    this.currency,
    this.amount,
    this.status,
    this.description,
    this.startDate,
  });

  int transactionId;
  String date;
  String currency;
  String amount;
  String status;
  String description;
  DateTime startDate;

  factory TransactionDatum.fromJson(Map<String, dynamic> json) => TransactionDatum(
    transactionId: json["transactionId"],
    date: json["date"],
    currency: json["currency"],
    amount: json["amount"],
    status: json["status"],
    description: json["description"],
    startDate: DateTime.parse(json["startDate"]),
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "date": date,
    "currency": currency,
    "amount": amount,
    "status": status,
    "description": description,
    "startDate": startDate.toIso8601String(),
  };
}

