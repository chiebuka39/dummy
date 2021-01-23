class GottenRate {
  String currency;
  num rate;

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

class ConvertedRate {
  num sourceAmount;
  num destinationAmount;
  String conversationRate;

  ConvertedRate(
      {this.sourceAmount, this.destinationAmount, this.conversationRate});

  ConvertedRate.fromJson(Map<String, dynamic> json) {
    sourceAmount = json['sourceAmount'];
    destinationAmount = json['destinationAmount'];
    conversationRate = json['conversationRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceAmount'] = this.sourceAmount;
    data['destinationAmount'] = this.destinationAmount;
    data['conversationRate'] = this.conversationRate;
    return data;
  }
}