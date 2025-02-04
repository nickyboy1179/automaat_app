import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:automaat_app/locator.dart';
import 'package:automaat_app/database/database.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';

class CarListController {
  final _restClient = locator<RestClient>();
  final _database = locator<AppDatabase>();
  final _secureStorage = locator<FlutterSecureStorage>();
  Set<int> loadedPages = {};
  int page = 0;
  int size = 10;

  Future<void> loadLoadedPages() async {
    final String? loadedPagesString =
        await _secureStorage.read(key: 'loadedPages');

    if (loadedPagesString != null && loadedPagesString.isNotEmpty) {
      loadedPages = loadedPagesString.split(',').map(int.parse).toSet();
    }
  }

  Future<void> saveLoadedPages() async {
    final loadedPagesString = loadedPages.join(',');
    await _secureStorage.write(key: 'loadedPages', value: loadedPagesString);
  }

  Future<List<Car>> fetchCarList({
    bool forceNetworkFetch = false,
  }) async {
    List<Car> cars = [];

    if (loadedPages.contains(page) && !forceNetworkFetch) {
      final localCars = await _database.carDao.getCarsByPage(page * size, size);
      if (localCars.isNotEmpty) {
        cars.addAll(localCars);
      }
    }

    if (cars.isEmpty || forceNetworkFetch) {
      final List<Car> fetchedCars = await _restClient.getCars(page, size);

      if (fetchedCars.isNotEmpty && loadedPages.contains(page) == false) {
        await _database.carDao.insertCars(fetchedCars);
        loadedPages.add(page);
        await saveLoadedPages();
      }

      cars.addAll(fetchedCars);
    }

    return cars;
  }

  void incrementPage() {
    page++;
  }
}
