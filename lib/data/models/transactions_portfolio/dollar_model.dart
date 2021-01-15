class DollarPortfolioTransactions {
  int productId;
  int instrumentId;
  String instrumentName;
  int transactionId;
  String percentageInterest;
  String currentValue;
  bool isMatured;
  double withdrawableValue;
  String maturityDate;
  String zimvestInstrumentName;
  String uniqueName;

  DollarPortfolioTransactions(
      {this.productId,
      this.instrumentId,
      this.instrumentName,
      this.transactionId,
      this.percentageInterest,
      this.currentValue,
      this.isMatured,
      this.withdrawableValue,
      this.maturityDate,
      this.zimvestInstrumentName,
      this.uniqueName});

  DollarPortfolioTransactions.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    instrumentId = json['instrumentId'];
    instrumentName = json['instrumentName'];
    transactionId = json['transactionId'];
    percentageInterest = json['percentageInterest'];
    currentValue = json['currentValue'];
    isMatured = json['isMatured'];
    withdrawableValue = json['withdrawableValue'];
    maturityDate = json['maturityDate'];
    zimvestInstrumentName = json['zimvestInstrumentName'];
    uniqueName = json['uniqueName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['instrumentId'] = this.instrumentId;
    data['instrumentName'] = this.instrumentName;
    data['transactionId'] = this.transactionId;
    data['percentageInterest'] = this.percentageInterest;
    data['currentValue'] = this.currentValue;
    data['isMatured'] = this.isMatured;
    data['withdrawableValue'] = this.withdrawableValue;
    data['maturityDate'] = this.maturityDate;
    data['zimvestInstrumentName'] = this.zimvestInstrumentName;
    data['uniqueName'] = this.uniqueName;
    return data;
  }
}