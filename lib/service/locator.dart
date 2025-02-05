import 'package:automaat_app/database/dao/car_dao.dart';
import 'package:automaat_app/service/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../database/database.dart';
import '../model/retrofit/rest_client.dart';
import '../model/retrofit/dio_client.dart';

final GetIt locator = GetIt.instance;

void setupLocator() async{
  // Flutter Secure Storage
  locator.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),));

  // Rest Client
  final dio = buildDioClient("https://talented-loving-llama.ngrok-free.app/api");
  locator.registerLazySingleton<RestClient>(() => RestClient(dio));

  // Floor database
  locator.registerSingletonAsync<AppDatabase>(() async => $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build());
  
  // Database DAO's
  locator.registerSingletonWithDependencies<CarDao>(
      () => locator<AppDatabase>().carDao,
      dependsOn: [AppDatabase]);

  // Notification service
  locator.registerSingletonAsync<NotificationService>(() async => NotificationService());
}