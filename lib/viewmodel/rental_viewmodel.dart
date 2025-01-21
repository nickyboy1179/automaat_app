import 'package:automaat_app/model/rest_model/rental_model.dart';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';

import 'package:automaat_app/model/rest_model/about_me_model.dart';

class RentalViewmodel {
  final restClient = locator<RestClient>();

  Future<List<Rental>> getUserRentals() async {
    AboutMe userInfo = await restClient.getUserInfo();
    String customerId = "${userInfo.id}";
    return await restClient.getRentalsByCustomerId(customerId, "0", "20");
  }
}