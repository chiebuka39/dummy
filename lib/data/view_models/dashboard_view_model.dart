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
     print(",,, ${result.data}");
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