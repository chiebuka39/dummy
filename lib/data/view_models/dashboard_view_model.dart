import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSDashboardViewModel extends ChangeNotifier{
  DashboardModel _dashboardModel = DashboardModel();
  List<PortfolioDistribution> _portfolioDistribution = [];
  AssetDistribution _assetDistribution;

  DashboardModel get dashboardModel => _dashboardModel;
  AssetDistribution get assetDistribution => _assetDistribution;
  List<PortfolioDistribution> get portfolioDistribution => _portfolioDistribution;

  set dashboardModel(DashboardModel value);
  set assetDistribution(AssetDistribution value);
  set portfolioDistribution(List<PortfolioDistribution> value);

  Future<Result<void>> getPortfolioValue(String token);
  Future<Result<AssetDistribution>> getAssetDistribution(String token);
  Future<Result<List<PortfolioDistribution>>> getPortfolioDistribution(String token);

}

class DashboardViewModel extends ABSDashboardViewModel{
  ABSDashboardService _dashboardService = locator<ABSDashboardService>();

  set dashboardModel(DashboardModel value){
    _dashboardModel = value;
    notifyListeners();
  }

  set assetDistribution(AssetDistribution value){
    _assetDistribution = value;
    notifyListeners();
  }

  set portfolioDistribution(List<PortfolioDistribution> value){
    _portfolioDistribution = value;
    notifyListeners();
  }


  @override
  Future<Result<void>> getPortfolioValue(String token)async {
     var result =await _dashboardService.getPortfolioValue(token);
     if(result.error == false){
       dashboardModel = result.data;
     }
     var result1 =await _dashboardService.getNairaPortfolio(token);
     if(result1.error == false){
       DashboardModel dashboardModel1 = dashboardModel;
       dashboardModel1.nairaInvestment = result1.data.nairaInvestment;
       dashboardModel1.nairaWallet = result1.data.nairaWallet;
       dashboardModel1.nairaSavings = result1.data.nairaSavings;
       dashboardModel = dashboardModel1;
     }
     var result2 =await _dashboardService.getDollarPortfolio(token);
     if(result2.error == false){
       DashboardModel dashboardModel1 = dashboardModel;
       dashboardModel1.dollarInvestment = result2.data.dollarInvestment;
       dashboardModel1.dollarWallet = result2.data.dollarWallet;
       dashboardModel = dashboardModel1;
     }

     dashboardModel = DashboardModel.calculateNairaPercent(dashboardModel);
     dashboardModel = DashboardModel.calculateDollarPercent(dashboardModel);


     return result;
  }

  @override
  Future<Result<List<PortfolioDistribution>>> getPortfolioDistribution(String token)async {
    var result =await _dashboardService.getPortfolioDistribution(token);

    if(result.error == false){
      portfolioDistribution = result.data;
    }
    print(",,, ${result.data}");
    return result;
  }

  @override
  Future<Result<AssetDistribution>> getAssetDistribution(String token)async {
    var result =await _dashboardService.getAssetDistribution(token);

    if(result.error == false){
      assetDistribution = result.data;
    }
    print(",,, ${result.data}");
    return result;
  }



}