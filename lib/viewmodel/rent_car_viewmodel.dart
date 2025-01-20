import 'package:automaat_app/locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/rest_model/customer_model.dart';
import 'package:automaat_app/model/rest_model/about_me_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:intl/intl.dart';

class RentCarViewmodel {
  final restClient = locator<RestClient>();
  final secureStorage = locator<FlutterSecureStorage>();

  Future<void> postRental(Car car, DateTime startDate, DateTime endDate) async {
    AboutMe user = await restClient.getUserInfo();

    Customer customer = Customer(
      id: user.id,
      nr: user.nr,
      lastName: user.lastName,
      firstName: user.firstName,
      from: user.from,
    );

    Rental rental = Rental(
      id: null,
      code: 'license vicinity mixture',
      longitude: car.longitude,
      latitude: car.latitude,
      fromDate: DateFormat('yyyy-MM-dd').format(startDate),
      toDate: DateFormat('yyyy-MM-dd').format(endDate),
      state: 'RESERVED',
      inspections: null,
      customer: customer,
      car: car,
    );

    await restClient.postRental(rental);
  }
}