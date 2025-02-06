import 'package:automaat_app/service/locator.dart';
import 'package:automaat_app/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/model/retrofit/rest_client.dart';

class LoginController {
  final _restClient = locator<RestClient>();

  Future<bool> authenticate(BuildContext context, String email, String password) async {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    try {
      final authRequest = AuthRequest(
        username: email,
        password: password,
        rememberMe: true,
      );
      final response = await _restClient.authenticate(authRequest);
      await auth.login(response.id_token);
      return true;
    } catch (e) {
      return false;
    }
  }

}