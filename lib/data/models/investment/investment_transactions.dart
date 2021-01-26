class InvestmentTransactions {
  String date;
  String uniqueName;
  String instrumentType;
  String description;
  String currency;
  String amount;
  String status;
  String startDate;

  InvestmentTransactions(
      {this.date,
      this.uniqueName,
      this.instrumentType,
      this.description,
      this.currency,
      this.amount,
      this.status,
      this.startDate});

  InvestmentTransactions.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    uniqueName = json['uniqueName'];
    instrumentType = json['instrumentType'];
    description = json['description'];
    currency = json['currency'];
    amount = json['amount'];
    status = json['status'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['uniqueName'] = this.uniqueName;
    data['instrumentType'] = this.instrumentType;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['startDate'] = this.startDate;
    return data;
  }
}