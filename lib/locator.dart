import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repository/retrofit/rest_client.dart';
import 'repository/retrofit/dio_client.dart';


final GetIt locator = GetIt.instance;

void setupLocator() async{
  // Flutter Secure Storage
  locator.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  // Rest Client
  final dio = buildDioClient("https://talented-loving-llama.ngrok-free.app/api");
  locator.registerLazySingleton<RestClient>(() => RestClient(dio));
}