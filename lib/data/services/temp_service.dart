import 'package:dio/dio.dart';
import 'package:zimvest/data/models/others/assets.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';
import 'package:zimvest/utils/strings.dart';

abstract class ABSTempService{
  Future<Result<List<Asset>>> getAssetTypes(String token,String type);
}

class TempService extends ABSTempService{
  final dio = locator<Dio>();
  @override
  Future<Result<List<Asset>>> getAssetTypes(String token, String type)async {
    Result<List<Asset>> result = Result(error: false);

    var headers = {
      "Authorization":"Bearer $token"
    };

    var url = "${AppStrings.baseUrl}zimvest.services.investment/api/MyPlanner/"
        "AssetsLiabilities?assetLiabilityType=$type";

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
        List<Asset> types = [];
        (response1['data'] as List).forEach((chaList) {
          //initialize Chat Object
          types.add(Asset.fromJson(chaList));
        });
        result.data = types;
      }

    }on DioError catch(e){
      print("error $e");
      result.error = true;
    }

    return result;
  }

}