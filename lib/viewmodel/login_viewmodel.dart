import 'package:automaat_app/locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../repository/retrofit/rest_client.dart';

class LoginViewmodel {
  final restClient = locator<RestClient>();
  final secureStorage = locator<FlutterSecureStorage>();

  Future<bool> authenticate(String email, String password) async {
    try {
      final authRequest = AuthRequest(
        username: email,
        password: password,
        rememberMe: true,
      );
      final response = await restClient.authenticate(authRequest);
      await secureStorage.write(key: "token", value: response.id_token);
      return true;

    } catch (e) {
      return false;
    }
  }
}