import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSDashboardViewModel extends ChangeNotifier{
  DashboardModel _dashboardModel;
  DashboardModel get dashboardModel => _dashboardModel;
  set dashboardModel(DashboardModel value);

  Future<Result<void>> getPortfolioValue(String token);
}

class DashboardViewModel extends ABSDashboardViewModel{
  ABSDashboardService _dashboardService = locator<ABSDashboardService>();

  set dashboardModel(DashboardModel value){
    _dashboardModel = value;
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

}