import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:zimvest/data/local/user_local.dart';
import 'package:zimvest/data/services/identity_service.dart';

GetIt locator = GetIt.asNewInstance();

void setUpLocator(){
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ABSIdentityService>(() => IdentityService());

  locator.registerLazySingleton<ABSStateLocalStorage>(() => StateBoxStorage());
}