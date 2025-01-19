import 'package:automaat_app/model/database/dao/car_dao.dart';
import '../locator.dart';
import '../model/rest_model/car_model.dart';
import '../model/retrofit/rest_client.dart';

class CarListViewmodel {
  final _restClient = locator<RestClient>();
  final _carDao = locator<CarDao>();

  Future<List<Car>> fetchCarList() async {
    final localCars = await _carDao.findAllCars();

    if (localCars.isNotEmpty) {
      return localCars;
    }

    final networkCars = await _restClient.getCars();
    await _carDao.insertCars(networkCars);

    return networkCars;
  }
}