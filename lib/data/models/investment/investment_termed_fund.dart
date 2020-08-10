class InvestmentTermFund {
  InvestmentTermFund({
    this.productId,
    this.termInstrumentId,
    this.termInstrumentName,
    this.percentageInterest,
    this.currentValue,
    this.isMatured,
    this.withdrawableValue,
    this.maturityDate,
  });

  int productId;
  int termInstrumentId;
  String termInstrumentName;
  String percentageInterest;
  String currentValue;
  bool isMatured;
  double withdrawableValue;
  DateTime maturityDate;

  factory InvestmentTermFund.fromJson(Map<String, dynamic> json) => InvestmentTermFund(
    productId: json["productId"],
    termInstrumentId: json["termInstrumentId"],
    termInstrumentName: json["termInstrumentName"],
    percentageInterest: json["percentageInterest"],
    currentValue: json["currentValue"],
    isMatured: json["isMatured"],
    withdrawableValue: json["withdrawableValue"].toDouble(),
    maturityDate: DateTime.parse(json["maturityDate"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "termInstrumentId": termInstrumentId,
    "termInstrumentName": termInstrumentName,
    "percentageInterest": percentageInterest,
    "currentValue": currentValue,
    "isMatured": isMatured,
    "withdrawableValue": withdrawableValue,
    "maturityDate": maturityDate.toIso8601String(),
  };
}