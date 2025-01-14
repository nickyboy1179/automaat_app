import '../locator.dart';
import '../model/rest_model/car_model.dart';
import '../model/retrofit/rest_client.dart';

class CarListViewmodel {
  final restClient = locator<RestClient>();

  Future<List<Car>> fetchCarList() async {
    return await restClient.getCars();
  }
}