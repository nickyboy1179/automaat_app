import 'package:automaat_app/service/locator.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/model/rest_model/car_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/view/rent_car_view.dart';

class CarController {
  final restClient = locator<RestClient>();

  Future<bool> checkCarAvailable(Car car) async {
    List<Rental> rentals = await restClient.getRentalsByCarIdAndState("RETURNED", "${car.id}", "0", "20");
    return rentals.isEmpty;
  }

  void onNavigate(BuildContext context, Car car) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RentCarView(car: car,)
        ),
    );
  }
}