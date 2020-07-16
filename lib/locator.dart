import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setUpLocator(){
  locator.registerLazySingleton<Dio>(() => Dio());
}