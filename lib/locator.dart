import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/dashboard_service.dart';
import 'package:zimvest/data/services/identity_service.dart';
import 'package:zimvest/data/services/investment_service.dart';
import 'package:zimvest/data/services/payment_service.dart';
import 'package:zimvest/data/services/savings_service.dart';

GetIt locator = GetIt.asNewInstance();

void setUpLocator(){
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ABSIdentityService>(() => IdentityService());
  locator.registerLazySingleton<ABSInvestmentService>(() => InvestmentService());
  locator.registerLazySingleton<ABSDashboardService>(() => DashboardService());
  locator.registerLazySingleton<ABSPaymentService>(() => PaymentService());
  locator.registerLazySingleton<ABSSavingService>(() => SavingService());

  locator.registerLazySingleton<ABSStateLocalStorage>(() => StateBoxStorage());
}