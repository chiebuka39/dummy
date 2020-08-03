class DashboardModel{
  String nairaPortfolio;
  String dollarPortfolio;
  String totalPortfolio;

  DashboardModel({this.dollarPortfolio, this.nairaPortfolio, this.totalPortfolio});

  static DashboardModel fromJson(Map<String, dynamic> map) {
    return DashboardModel(
        nairaPortfolio: map['nairaPortfolio'] ?? '',
        totalPortfolio: map['totalPortfolio'] ?? '',
        dollarPortfolio: map['dollarPortfolio'] ?? '',

    );
  }
}