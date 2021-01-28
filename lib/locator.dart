import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/account_settings_service.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/data/services/fixed_income_investment_service.dart';
import 'package:zimvest/data/services/identity_service.dart';
import 'package:zimvest/data/services/investment_service.dart';
import 'package:zimvest/data/services/liquidate_asset_service.dart';

import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/data/services/savings_service.dart';
import 'package:zimvest/data/services/temp_service.dart';
import 'package:zimvest/data/services/transaction_services.dart';
import 'package:zimvest/data/services/wallet_service.dart';

import 'data/models/transactions_portfolio/naira_model.dart';
import 'data/services/others_service.dart';
import 'main.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<Dio>(() {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (Options options){
          options.receiveTimeout = 3000;
          options.sendTimeout = 3000;
          debugPrint("Omo interceptor was added");
          return options;
        }
    ));
    return dio;
  });
  locator.registerLazySingleton<ABSOthersService>(() => OthersService());
  locator.registerLazySingleton<ABSTempService>(() => TempService());
  locator.registerLazySingleton<ABSIdentityService>(() => IdentityService());
  locator.registerLazySingleton<ABSInvestmentService>(() => InvestmentService());
  locator.registerLazySingleton<ABSDashboardService>(() => DashboardService());
  locator.registerLazySingleton<ABSPaymentService>(() => PaymentService());
  locator.registerLazySingleton<ABSSavingService>(() => SavingService());
  locator.registerLazySingleton<ABSSettingsService>(() => SettingsService());


  locator.registerLazySingleton<ABSStateLocalStorage>(() => StateBoxStorage());
  locator.registerLazySingleton<ABSFixedIncomeInvestmentService>(() => FixedIncomeInvestmentService());
  locator.registerLazySingleton<ABSWalletService>(() => WalletService());
  locator.registerLazySingleton<ABSTransactionService>(() => TransactionService());
  locator.registerLazySingleton<ABSLiquidateAssets>(() => LiquidateAssets());
}