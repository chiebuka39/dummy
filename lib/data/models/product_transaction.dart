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


