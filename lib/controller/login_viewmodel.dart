import 'package:automaat_app/locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/retrofit/rest_client.dart';

class LoginViewmodel {
  final _restClient = locator<RestClient>();
  final _secureStorage = locator<FlutterSecureStorage>();

  Future<bool> authenticate(String email, String password) async {
    try {
      final authRequest = AuthRequest(
        username: email,
        password: password,
        rememberMe: true,
      );
      final response = await _restClient.authenticate(authRequest);
      await _secureStorage.write(key: "token", value: response.id_token);
      return true;

    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final String? token = await _secureStorage.read(key: 'token');
    // Wait until DI container has finished initializing.
    await locator.allReady();
    return token != null && token.isNotEmpty;
  }
}