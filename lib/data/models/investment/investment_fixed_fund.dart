class InvestmentFixedFund {
  InvestmentFixedFund({
    this.productId,
    this.fixedIncomeId,
    this.fixedIncomeName,
    this.percentageInterest,
    this.currentValue,
    this.isMatured,
    this.withdrawableValue,
    this.maturityDate,
  });

  int productId;
  int fixedIncomeId;
  String fixedIncomeName;
  String percentageInterest;
  String currentValue;
  bool isMatured;
  double withdrawableValue;
  DateTime maturityDate;

  factory InvestmentFixedFund.fromJson(Map<String, dynamic> json) => InvestmentFixedFund(
    productId: json["productId"],
    fixedIncomeId: json["fixedIncomeId"],
    fixedIncomeName: json["fixedIncomeName"],
    percentageInterest: json["percentageInterest"],
    currentValue: json["currentValue"],
    isMatured: json["isMatured"],
    withdrawableValue: json["withdrawableValue"],
    maturityDate: DateTime.parse(json["maturityDate"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "fixedIncomeId": fixedIncomeId,
    "fixedIncomeName": fixedIncomeName,
    "percentageInterest": percentageInterest,
    "currentValue": currentValue,
    "isMatured": isMatured,
    "withdrawableValue": withdrawableValue,
    "maturityDate": maturityDate.toIso8601String(),
  };
}

