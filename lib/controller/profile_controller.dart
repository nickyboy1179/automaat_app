import 'package:automaat_app/database/database.dart';
import 'package:automaat_app/model/rest_model/customer_model.dart';
import 'package:automaat_app/service/locator.dart';
import 'package:automaat_app/model/rest_model/about_me_model.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';

class ProfileController {
  final _restClient = locator<RestClient>();
  final _database = locator<AppDatabase>();

  Future<AboutMe> getUserInfo() async {
    AboutMe user = await _restClient.getUserInfo();
    return user;
  }

  Future<Customer> getUserInfoLocal() async {
    List<Customer> customers = await _database.customerDao.getAllCustomers();
    return customers[0];
  }
}