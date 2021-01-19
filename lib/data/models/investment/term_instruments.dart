class TermInstrument {
  int id;
  String instrumentName;
  int investmentType;
  int investmentCategory;
  String depositRate;
  String maturityDate;
  String minimumAmount;
  String maximumAmount;
  num minAmount;
  num maxAmount;
  int maturityPeriod;
  double rate;

  TermInstrument(
      {this.id,
      this.instrumentName,
      this.investmentType,
      this.investmentCategory,
      this.depositRate,
      this.maturityDate,
      this.minimumAmount,
      this.maximumAmount,
      this.minAmount,
      this.maxAmount,
      this.maturityPeriod,
      this.rate});

  TermInstrument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instrumentName = json['instrumentName'];
    investmentType = json['investmentType'];
    investmentCategory = json['investmentCategory'];
    depositRate = json['depositRate'];
    maturityDate = json['maturityDate'];
    minimumAmount = json['minimumAmount'];
    maximumAmount = json['maximumAmount'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
    maturityPeriod = json['maturityPeriod'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instrumentName'] = this.instrumentName;
    data['investmentType'] = this.investmentType;
    data['investmentCategory'] = this.investmentCategory;
    data['depositRate'] = this.depositRate;
    data['maturityDate'] = this.maturityDate;
    data['minimumAmount'] = this.minimumAmount;
    data['maximumAmount'] = this.maximumAmount;
    data['minAmount'] = this.minAmount;
    data['maxAmount'] = this.maxAmount;
    data['maturityPeriod'] = this.maturityPeriod;
    data['rate'] = this.rate;
    return data;
  }
}


