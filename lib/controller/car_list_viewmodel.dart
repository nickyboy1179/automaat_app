import '../locator.dart';
import '../model/database/database.dart';
import '../model/rest_model/car_model.dart';
import '../model/retrofit/rest_client.dart';

class CarListViewmodel {
  final _restClient = locator<RestClient>();
  final _carDao = locator<AppDatabase>();

  Future<List<Car>> fetchCarList({int page = 0, int size = 8}) async {
    // final localCars = await _carDao.carDao.findAllCars();
    //
    // if (localCars.isNotEmpty) {
    //   return localCars;
    // }

    final networkCars = await _restClient.getCars(page.toString(), size.toString());
    // await _carDao.carDao.insertCars(networkCars);

    return networkCars;
  }
}