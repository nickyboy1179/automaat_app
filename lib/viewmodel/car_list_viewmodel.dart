import 'package:automaat_app/model/database/database.dart';

import '../locator.dart';
import '../model/rest_model/car_model.dart';
import '../model/retrofit/rest_client.dart';

class CarListViewmodel {
  final restClient = locator<RestClient>();

  Future<List<Car>> fetchCarList() async {
    final appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final carDao = appDatabase.carDao;
    final localCars = await carDao.findAllCars();

    if (localCars.isNotEmpty) {
      return localCars;
    }

    final networkCars = await restClient.getCars();
    await appDatabase.carDao.insertCars(networkCars);

    return networkCars;
  }
}