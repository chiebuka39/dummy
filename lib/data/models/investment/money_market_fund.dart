class MutualFund {
  MutualFund({
    this.id,
    this.title,
    this.fundName,
    this.investmentType,
    this.investmentCategory,
    this.yieldRate,
  });

  int id;
  String title;
  String fundName;
  int investmentType;
  int investmentCategory;
  String yieldRate;

  factory MutualFund.fromJson(Map<String, dynamic> json) => MutualFund(
    id: json["id"],
    title: json["title"],
    fundName: json["fundName"],
    investmentType: json["investmentType"],
    investmentCategory: json["investmentCategory"],
    yieldRate: json["yieldRate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "fundName":fundName,
    "investmentType": investmentType,
    "investmentCategory": investmentCategory,
    "yieldRate": yieldRate,
  };
}


