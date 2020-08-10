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
  FixedIncomeName fixedIncomeName;
  PercentageInterest percentageInterest;
  String currentValue;
  bool isMatured;
  double withdrawableValue;
  DateTime maturityDate;

  factory InvestmentFixedFund.fromJson(Map<String, dynamic> json) => InvestmentFixedFund(
    productId: json["productId"],
    fixedIncomeId: json["fixedIncomeId"],
    fixedIncomeName: fixedIncomeNameValues.map[json["fixedIncomeName"]],
    percentageInterest: percentageInterestValues.map[json["percentageInterest"]],
    currentValue: json["currentValue"],
    isMatured: json["isMatured"],
    withdrawableValue: json["withdrawableValue"],
    maturityDate: DateTime.parse(json["maturityDate"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "fixedIncomeId": fixedIncomeId,
    "fixedIncomeName": fixedIncomeNameValues.reverse[fixedIncomeName],
    "percentageInterest": percentageInterestValues.reverse[percentageInterest],
    "currentValue": currentValue,
    "isMatured": isMatured,
    "withdrawableValue": withdrawableValue,
    "maturityDate": maturityDate.toIso8601String(),
  };
}

enum FixedIncomeName { TREASURY_BILL, COMMERCIAL_PAPER, PROMISSORY_NOTE }

final fixedIncomeNameValues = EnumValues({
  "Commercial Paper": FixedIncomeName.COMMERCIAL_PAPER,
  "Promissory Note": FixedIncomeName.PROMISSORY_NOTE,
  "Treasury Bill": FixedIncomeName.TREASURY_BILL
});

enum PercentageInterest { THE_1000_INTEREST, THE_300_INTEREST, THE_100_INTEREST }

final percentageInterestValues = EnumValues({
  "10.00 % Interest": PercentageInterest.THE_1000_INTEREST,
  "1.00 % Interest": PercentageInterest.THE_100_INTEREST,
  "3.00 % Interest": PercentageInterest.THE_300_INTEREST
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