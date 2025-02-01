import 'dart:io';
import 'dart:convert';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/model/rest_model/inspections_model.dart';
import 'package:automaat_app/model/rest_model/rental_model.dart';

class ReportController {
  final RestClient _restClient = locator<RestClient>();

  Future<bool> submitReport(Rental rental, String description, File image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64String = base64Encode(imageBytes);

    Inspection inspection = Inspection(
        id: null,
        code: null,
        odometer: null,
        result: null,
        description: description,
        photo: base64String,
        photoContentType: "img/png",
        completed: DateTime.now(),
    );

    try {
      await _restClient.postInspection(inspection);
      return true;
    } catch (e) {
      return false;
    }
  }

}