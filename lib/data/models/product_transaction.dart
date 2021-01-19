class ProductTransaction{
  double amount;
  DateTime dateCreated;
  DateTime dateUpdated;
  int id;
  int status;
  String statusText;
  String transactionDescription;
  String transactionType;

  ProductTransaction({this.id, this.amount, this.dateCreated,
    this.dateUpdated,this.status,
    this.statusText,
    this.transactionDescription, this.transactionType});

  factory ProductTransaction.fromJson(Map<String, dynamic> json) => ProductTransaction(
    id: json["id"],
    transactionType: json["transactionType"],
    transactionDescription: json["transactionDescription"],
    amount: json["amount"].toDouble(),
    status: json["status"],
    statusText: json["statusText"],
    dateCreated: DateTime.parse(json["dateCreated"]),
    dateUpdated: DateTime.parse(json["dateUpdated"]),
  );

}

class InvestmentTransaction {
  InvestmentTransaction({
    this.productId,
    this.instrumentId,
    this.instrumentName,
    this.transactionId,
    this.percentageInterest,
    this.currentValue,
    this.isMatured,
    this.withdrawableValue,
    this.maturityDate,
    this.zimvestInstrumentName,
    this.uniqueName,
  });

  int productId;
  int instrumentId;
  String instrumentName;
  int transactionId;
  String percentageInterest;
  String currentValue;
  bool isMatured;
  int withdrawableValue;
  DateTime maturityDate;
  String zimvestInstrumentName;
  String uniqueName;

  factory InvestmentTransaction.fromJson(Map<String, dynamic> json) => InvestmentTransaction(
    productId: json["productId"],
    instrumentId: json["instrumentId"],
    instrumentName: json["instrumentName"],
    transactionId: json["transactionId"],
    percentageInterest: json["percentageInterest"],
    currentValue: json["currentValue"],
    isMatured: json["isMatured"],
    withdrawableValue: json["withdrawableValue"],
    maturityDate: DateTime.parse(json["maturityDate"]),
    zimvestInstrumentName: json["zimvestInstrumentName"],
    uniqueName: json["uniqueName"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "instrumentId": instrumentId,
    "instrumentName": instrumentName,
    "transactionId": transactionId,
    "percentageInterest": percentageInterest,
    "currentValue": currentValue,
    "isMatured": isMatured,
    "withdrawableValue": withdrawableValue,
    "maturityDate": maturityDate.toIso8601String(),
    "zimvestInstrumentName": zimvestInstrumentName,
    "uniqueName": uniqueName,
  };
}


