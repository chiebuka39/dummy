import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/liquidate_asset_service.dart';
import 'package:zimvest/data/view_models/base_model.dart';
import 'package:zimvest/utils/result.dart';

import '../../locator.dart';

class LiquidateAssetViewModel extends BaseViewModel {
  bool _status = false;
  bool get status => _status;

  String _message = "";
  String get message => _message;
  final ABSStateLocalStorage _localStorage = locator<ABSStateLocalStorage>();
  final ABSLiquidateAssets _liquidateAssets = locator<ABSLiquidateAssets>();

  Future<Result<void>> liquidateNairaInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
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
            pin: pin);
    return liquidateNairaInstrument;
  }

  Future<Result<void>> liquidateDollarInstrument(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
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
    return liquidateDollarInstrument;
  }

  Future<Result<void>> liquidateCorporateBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument =
        await _liquidateAssets.liquidateCorporateBond(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    return liquidateDollarInstrument;
  }

  Future<Result<void>> liquidateCommercialPaper(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument =
        await _liquidateAssets.liquidateCommercialPapers(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    return liquidateDollarInstrument;
  }

  Future<Result<void>> liquidateEuroBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument = await _liquidateAssets.liquidateEuroBond(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    return liquidateDollarInstrument;
  }

  Future<Result<void>> liquidateFGNBond(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument = await _liquidateAssets.liquidateFGNBond(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    return liquidateDollarInstrument;
  }

  Future<Result<void>> liquidatePromissoryNote(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument =
        await _liquidateAssets.liquidatePromissoryNote(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    return liquidateDollarInstrument;
  }

  Future<Result<void>> liquidateTreasuryBill(
      {int transactionId,
      int instrumentId,
      int bankId,
      int withdrawalOption,
      double amount,
      String pin,
      int withdrawableAmount,
      String requestSource,
      String token}) async {
    setBusy(true);
    String token = _localStorage.getUser().token;
    var liquidateDollarInstrument =
        await _liquidateAssets.liquidateTreasuryBill(
      transactionId: transactionId,
      instrumentId: instrumentId,
      bankId: bankId,
      withdrawalOption: withdrawalOption,
      withdrawableAmount: withdrawableAmount,
      amount: amount,
      token: token,
    );
    return liquidateDollarInstrument;
  }
}
