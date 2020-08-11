class TermInstrument {
  TermInstrument({
    this.id,
    this.instrumentName,
    this.investmentType,
    this.investmentCategory,
    this.depositRate,
    this.maturityDate,
    this.minimumAmount,
    this.maximumAmount,
  });

  int id;
  String instrumentName;
  int investmentType;
  int investmentCategory;
  String depositRate;
  String maturityDate;
  String minimumAmount;
  String maximumAmount;

  factory TermInstrument.fromJson(Map<String, dynamic> json) => TermInstrument(
    id: json["id"],
    instrumentName: json["instrumentName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    depositRate: json["depositRate"],
    maturityDate: json["maturityDate"],
    minimumAmount: json["minimumAmount"],
    maximumAmount: json["maximumAmount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instrumentName": instrumentName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "depositRate": depositRate,
    "maturityDate": maturityDate,
    "minimumAmount": minimumAmount,
    "maximumAmount": maximumAmount,
  };
}


