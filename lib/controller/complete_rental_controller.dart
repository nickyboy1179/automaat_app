import 'package:automaat_app/model/rest_model/inspections_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:latlong2/latlong.dart';

class CompleteRentalController {
  final RestClient _restClient = locator<RestClient>();

  Future<Position?> getCurrentLocation(BuildContext context) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      if (!context.mounted) return null;
      _showError("Location services are disabled.", context);
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!context.mounted) return null;
        _showError("Location permissions are denied.", context);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) return null;
      _showError("Location permissions are permanently denied.", context);
      return null;
    }

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    return position;
  }

  void _showError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<bool> sendConfirmation(Rental rental, LatLng latLng, String mileage) async {
    try {
      // int? mileageInt = int.tryParse(mileage);
      // Inspection inspection = Inspection(
      //     id: null,
      //     code: null,
      //     odometer: mileageInt,
      //     result: null,
      //     description: null,
      //     photo: "agsdfasdf",
      //     photoContentType: "img/png",
      //     completed: DateTime.now(),
      // );
      //
      // var response = await _restClient.postInspection(inspection);

      rental.longitude = latLng.longitude;
      rental.latitude = latLng.latitude;
      rental.state = "PICKUP";

      await _restClient.putRental(rental, rental.id as int);

      return true;
    } catch (e) {
      return false;
    }
  }
}