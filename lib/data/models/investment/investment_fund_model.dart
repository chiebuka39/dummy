class InvestmentMutualFund {
  InvestmentMutualFund({
    this.productId,
    this.fundId,
    this.fundName,
    this.percentageInterest,
    this.currentValue,
    this.withdrawableValue,
  });

  int productId;
  int fundId;
  String fundName;
  String percentageInterest;
  String currentValue;
  int withdrawableValue;

  factory InvestmentMutualFund.fromJson(Map<String, dynamic> json) => InvestmentMutualFund(
        productId: json["productId"],
        fundId: json["fundId"],
        fundName: json["fundName"],
        percentageInterest: json["percentageInterest"],
        currentValue: json["currentValue"],
        withdrawableValue: json["withdrawableValue"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "fundId": fundId,
        "fundName": fundName,
        "percentageInterest": percentageInterest,
        "currentValue": currentValue,
        "withdrawableValue": withdrawableValue,
      };
}



class InvestmentActivity {
  InvestmentActivity({
    this.date,
    this.transactionId,
    this.instrumentId,
    this.instrumentType,
    this.currency,
    this.amount,
    this.status,
    this.description,
    this.startDate,
  });

  String date;
  int transactionId;
  int instrumentId;
  InstrumentType instrumentType;
  Currency currency;
  String amount;
  Status status;
  Description description;
  DateTime startDate;

  factory InvestmentActivity.fromJson(Map<String, dynamic> json) => InvestmentActivity(
    date: json["date"],
    transactionId: json["transactionId"],
    instrumentId: json["instrumentId"],
    instrumentType: instrumentTypeValues.map[json["instrumentType"]],
    currency: currencyValues.map[json["currency"]],
    amount: json["amount"],
    status: statusValues.map[json["status"]],
    description: descriptionValues.map[json["description"]],
    startDate: DateTime.parse(json["startDate"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "transactionId": transactionId,
    "instrumentId": instrumentId,
    "instrumentType": instrumentTypeValues.reverse[instrumentType],
    "currency": currencyValues.reverse[currency],
    "amount": amount,
    "status": statusValues.reverse[status],
    "description": descriptionValues.reverse[description],
    "startDate": startDate.toIso8601String(),
  };
}

enum Currency { NGN, USD }

final currencyValues = EnumValues({
  "NGN": Currency.NGN,
  "USD": Currency.USD
});

enum Description { SUBSCRIPTION, WITHDRAWAL }

final descriptionValues = EnumValues({
  "Subscription": Description.SUBSCRIPTION,
  "Withdrawal": Description.WITHDRAWAL
});

enum InstrumentType { MONEY_MARKET_FUND, DOLLAR_FUND }

final instrumentTypeValues = EnumValues({
  "Dollar Fund": InstrumentType.DOLLAR_FUND,
  "Money Market Fund": InstrumentType.MONEY_MARKET_FUND
});

enum Status { PAYMENT_FAILED, SUCCESSFUL, PAYMENT_SUCCESSFUL, FAILED }

final statusValues = EnumValues({
  "Failed": Status.FAILED,
  "Payment Failed": Status.PAYMENT_FAILED,
  "Payment successful": Status.PAYMENT_SUCCESSFUL,
  "Successful": Status.SUCCESSFUL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
