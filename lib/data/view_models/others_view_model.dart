import 'package:flutter/foundation.dart';
import 'package:zimvest/data/models/others/assets.dart';
import 'package:zimvest/data/services/others_service.dart';
import 'package:zimvest/locator.dart';
import 'package:zimvest/utils/result.dart';

abstract class ABSOthersViewModel extends ChangeNotifier{

  Future<Result<List<Asset>>> getAssetTypes(String token,String type);


}

class OthersViewModel extends ABSOthersViewModel{
  ABSOthersService _othersService = locator<ABSOthersService>();


  @override
  Future<Result<List<Asset>>> getAssetTypes(String token,String type)async {
    return _othersService.getAssetTypes(token,type);
  }

}