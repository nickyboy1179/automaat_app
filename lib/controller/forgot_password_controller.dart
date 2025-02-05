import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:automaat_app/service/locator.dart';

class ForgotPasswordController {
  final RestClient _restClient = locator<RestClient>();

  Future<void> forgotPassword(String email) async {
    try {
      await _restClient.postForgotPassword(email);
    } catch (e) {
      //print(e)
    }
  }

}