class DashboardModel{
  String nairaPortfolio;
  String dollarPortfolio;
  String totalPortfolio;

  DashboardModel({this.dollarPortfolio = "0.01",
    this.nairaPortfolio ="0.01", this.totalPortfolio= "0.01"});

  static DashboardModel fromJson(Map<String, dynamic> map) {
    return DashboardModel(
        nairaPortfolio: map['nairaPortfolio'] ?? '',
        totalPortfolio: map['totalPortfolio'] ?? '',
        dollarPortfolio: map['dollarPortfolio'] ?? '',

    );
  }
}

class PortfolioDistribution {
  PortfolioDistribution({
    this.portfolioName,
    this.percentageShare,
  });

  String portfolioName;
  double percentageShare;

  factory PortfolioDistribution.fromJson(Map<String, dynamic> json) => PortfolioDistribution(
    portfolioName: json["portfolioName"],
    percentageShare: json["percentageShare"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "portfolioName": portfolioName,
    "percentageShare": percentageShare,
  };
}

class AssetDistribution {
  AssetDistribution({
    this.model,
    this.invesmentPortfolioBalance,
    this.dateJoined,
  });

  List<Model> model;
  String invesmentPortfolioBalance;
  String dateJoined;

  factory AssetDistribution.fromJson(Map<String, dynamic> json) => AssetDistribution(
    model: List<Model>.from(json["model"].map((x) => Model.fromJson(x))),
    invesmentPortfolioBalance: json["invesmentPortfolioBalance"],
    dateJoined: json["dateJoined"],
  );

  Map<String, dynamic> toJson() => {
    "model": List<dynamic>.from(model.map((x) => x.toJson())),
    "invesmentPortfolioBalance": invesmentPortfolioBalance,
    "dateJoined": dateJoined,
  };
}

class Model {
  Model({
    this.instrumentName,
    this.percentageValue,
  });

  String instrumentName;
  double percentageValue;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    instrumentName: json["instrumentName"],
    percentageValue: json["percentageValue"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "instrumentName": instrumentName,
    "percentageValue": percentageValue,
  };
}