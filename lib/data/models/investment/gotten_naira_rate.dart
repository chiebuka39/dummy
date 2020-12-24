class GottenRate {
  String currency;
  int rate;

  GottenRate({this.currency, this.rate});

  GottenRate.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['rate'] = this.rate;
    return data;
  }
}

class ConvertedDollarRate {
  int amountUSD;
  int amountNGN;
  String conversationRate;

  ConvertedDollarRate({this.amountUSD, this.amountNGN, this.conversationRate});

  ConvertedDollarRate.fromJson(Map<String, dynamic> json) {
    amountUSD = json['amountUSD'];
    amountNGN = json['amountNGN'];
    conversationRate = json['conversationRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amountUSD'] = this.amountUSD;
    data['amountNGN'] = this.amountNGN;
    data['conversationRate'] = this.conversationRate;
    return data;
  }
}
