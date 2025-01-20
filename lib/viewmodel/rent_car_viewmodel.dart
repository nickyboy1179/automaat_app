import 'package:automaat_app/locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/rest_model/car_model.dart';
import '../model/rest_model/customer_model.dart';
import '../model/retrofit/rest_client.dart';
import '../model/rest_model/rental_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RentCarViewmodel {
  final restClient = locator<RestClient>();
  final secureStorage = locator<FlutterSecureStorage>();
  final String baseUrl = "https://talented-loving-llama.ngrok-free.app/api";

  Future<bool> postRental(Car car, DateTime startDate, DateTime endDate) async {
    Customer customer = Customer(
      id: 2,
      nr: 1002,
      lastName: "Johnson",
      firstName: "Emily",
      from: "2019-02-10",
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

    var token = await secureStorage.read(key: 'token');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var payload = json.encode(rental.toJson());

    final response = await restClient.postRental(rental);
    // final response = await http.post(
    //   Uri.parse('$baseUrl/rentals'),
    //   headers: headers,
    //   body: payload,
    // );
    // if (response.statusCode == 201) {
    //   print("SUCCES!");
    // } else {
    //   print("NOOO");
    // }
    return true;
  }
}