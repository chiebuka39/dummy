class DashboardModel{
  String nairaPortfolio;
  String dollarPortfolio;
  String totalPortfolio;

  DashboardModel({this.dollarPortfolio = "0.0",
    this.nairaPortfolio ="0.0", this.totalPortfolio= "0.0"});

  static DashboardModel fromJson(Map<String, dynamic> map) {
    return DashboardModel(
        nairaPortfolio: map['nairaPortfolio'] ?? '',
        totalPortfolio: map['totalPortfolio'] ?? '',
        dollarPortfolio: map['dollarPortfolio'] ?? '',

    );
  }
}