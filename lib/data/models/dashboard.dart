class DashboardModel{
  String nairaPortfolio;
  String dollarPortfolio;
  String totalPortfolio;
  String nairaWallet;
  String nairaInvestment;
  String dollarInvestment;
  String dollarWallet;
  String nairaSavings;

  double nairaSavingPercent;
  double nairaInvestmentPercent;
  double nairaWalletPercent;

  double dollarInvestmentPercent;
  double dollarWalletPercent;

  DashboardModel({this.dollarPortfolio = "0.01",
    this.nairaPortfolio ="0.01",
    this.totalPortfolio= "0.01",
    this.dollarInvestment = "0.01",
    this.nairaInvestment = "0.01",
    this.nairaSavings = "0.01",
    this.nairaWallet = "0.01",
    this.dollarWallet = "0.01",

    this.dollarInvestmentPercent,
    this.dollarWalletPercent,
    this.nairaInvestmentPercent,
    this.nairaSavingPercent,
    this.nairaWalletPercent
  });

  static DashboardModel fromJson(Map<String, dynamic> map) {
    return DashboardModel(
        nairaPortfolio: map['nairaPortfolio'] ?? '',
        totalPortfolio: map['totalPortfolio'] ?? '',
        dollarPortfolio: map['dollarPortfolio'] ?? '',

    );
  }
  static DashboardModel calculateNairaPercent(DashboardModel dashboardModel){
    double savings = double.parse(dashboardModel.nairaSavings.substring(1).replaceAll(',', ''));
    double investment = double.parse(dashboardModel.nairaInvestment.substring(1).replaceAll(',', ''));
    double wallet = double.parse(dashboardModel.nairaWallet.substring(1).replaceAll(',', ''));

    double total = savings + investment + wallet;

    double savingsPercent = (savings/total) * 100;
    double investmentPercent = (investment/total) * 100;
    double walletPercent = (wallet/total) * 100;

    print("lll<<<s<<<<<<<< $savingsPercent");
    print("lll<<w<<<<<<<<< $walletPercent");
    print("lll<<<<<<i<<<<< $investmentPercent");

    dashboardModel.nairaSavingPercent = savingsPercent;
    dashboardModel.nairaWalletPercent = walletPercent;
    dashboardModel.nairaInvestmentPercent = investmentPercent;
    return dashboardModel;
  }
  static double savingSum(DashboardModel dashboardModel){
    double savings = double.parse(dashboardModel.nairaSavings.substring(1).replaceAll(',', ''));
    double investment = double.parse(dashboardModel.nairaInvestment.substring(1).replaceAll(',', ''));
    double wallet = double.parse(dashboardModel.nairaWallet.substring(1).replaceAll(',', ''));

    double total = savings + investment + wallet;

    return total;
  }
  static DashboardModel calculateDollarPercent(DashboardModel dashboardModel){
    double investment = double.parse(dashboardModel.dollarInvestment.substring(1).replaceAll(',', ''));
    double wallet = double.parse(dashboardModel.dollarWallet.substring(1).replaceAll(',', ''));

    print("lll<<<s<<<<999<<<< $wallet");

    print("lll<<<<<<i<<9999<<< $investment");
    double total = wallet + investment ;

    double savingsPercent = (wallet/total) * 100;
    double investmentPercent = (investment/total) * 100;

    print("lll<<<s<<<<<<<< $savingsPercent");

    print("lll<<<<<<i<<<<< $investmentPercent");

    dashboardModel.dollarWalletPercent = wallet;

    dashboardModel.dollarInvestmentPercent = investmentPercent;
    return dashboardModel;
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