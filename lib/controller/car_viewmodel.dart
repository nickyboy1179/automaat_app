import 'package:automaat_app/locator.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';

class CarViewmodel {
  final restClient = locator<RestClient>();

  Future<bool> checkCarAvailable(Car car) async {
    List<Rental> rentals = await restClient.getRentalsByCarIdAndState("RETURNED", "${car.id}", "0", "20");
    return rentals.isEmpty;
  }

}