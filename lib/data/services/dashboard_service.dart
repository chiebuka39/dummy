import 'package:dio/dio.dart';
import 'package:zimvest/data/models/dashboard.dart';
import 'package:zimvest/data/models/user.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSDashboardService{
  Future<Result<DashboardModel>> getPortfolioValue(String token);
  Future<Result<void>> getAssetDistribution(String token);
  Future<Result<void>> getportfolioDistribution(String token);


}

class DashboardService extends ABSDashboardService{
  final dio = locator<Dio>();
  @override
  Future<Result<DashboardModel>> getPortfolioValue(String token) async{
    Result<DashboardModel> result = Result(error: false);

   var headers = {
     "Authorization":"Bearer $token"
   };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards/portfoliovalue";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
        var dashboardPortfolio = DashboardModel.fromJson(response1['data']);
        result.data = dashboardPortfolio;
      }

    }on DioError catch(e){
      print("error $e");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> getAssetDistribution(String token)async {
    Result<DashboardModel> result = Result(error: false);

    var headers = {
      "Authorization":"Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards/assetdistribution";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
//        var dashboardPortfolio = DashboardModel.fromJson(response1['data']);
//        result.data = dashboardPortfolio;
      }

    }on DioError catch(e){
      print("error $e");
      result.error = true;
    }

    return result;
  }

  @override
  Future<Result<void>> getportfolioDistribution(String token) async{
    Result<DashboardModel> result = Result(error: false);

    var headers = {
      "Authorization":"Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/Dashboards/portfoliodistribution";

    print("lll $url");
    try{
      var response = await dio.get(url, options: Options(headers: headers));
      final int statusCode = response.statusCode;
      var response1 = response.data;
      print("iii ${response1}");

      if (statusCode != 200) {
        result.errorMessage = response1['message'];
        result.error = true;
      }else {
        result.error = false;
//        var dashboardPortfolio = DashboardModel.fromJson(response1['data']);
//        result.data = dashboardPortfolio;
      }

    }on DioError catch(e){
      print("error $e");
      result.error = true;
    }

    return result;
  }



}