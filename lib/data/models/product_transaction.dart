class ProductTransaction{
  double amount;
  DateTime dateCreated;
  DateTime dateUpdated;
  int id;
  int status;
  StatusText statusText;
  String transactionDescription;
  int transactionType;

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
    statusText: statusTextValues.map[json["statusText"]],
    dateCreated: DateTime.parse(json["dateCreated"]),
    dateUpdated: DateTime.parse(json["dateUpdated"]),
  );

}

final statusTextValues = EnumValues({
  "COMPLETED": StatusText.COMPLETED,
  "FAILED": StatusText.FAILED,
  "PENDING": StatusText.PENDING
});


enum StatusText { COMPLETED, FAILED, PENDING }

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