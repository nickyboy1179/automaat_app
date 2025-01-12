import '../locator.dart';
import '../repository/model/cars.dart';
import '../repository/retrofit/rest_client.dart';

class CarListViewmodel {
  final restClient = locator<RestClient>();

  Future<List<Cars>> fetchCarList() async {
    return await restClient.getCars();
  }
}