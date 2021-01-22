import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/liquidate_asset_service.dart';
import 'package:zimvest/data/view_models/base_model.dart';

import '../../locator.dart';

class LiquidateAssetViewModel extends BaseViewModel {
  bool _status = false;
  bool get status => _status;

  String _message = "";
  String get message => _message;
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  final ABSLiquidateAssets _liquidateAssets = locator<ABSLiquidateAssets>();

  Future<void> liquidateNairaInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      int amount,
      String pin,
      double withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateNairaInstrument =
        await _liquidateAssets.liquidateNairaInstrument(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
      pin: pin
    );
    print(liquidateNairaInstrument);
    if (liquidateNairaInstrument != "Success") {
      setBusy(false);
      _status = true;
    } else {
      setBusy(false);
      _status = false;
    }
  }

  Future<void> liquidateDollarInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      int amount,
      String pin,
      double withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument =
        await _liquidateAssets.liquidateDollarInstrument(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    if (liquidateDollarInstrument != "Success") {
      setBusy(false);
      _status = true;
    } else {
      setBusy(false);
      _status = false;
    }
  }
}
