import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:automaat_app/service/locator.dart';

class AuthProvider with ChangeNotifier {
  final _secureStorage = locator<FlutterSecureStorage>();
  String? _token;
  bool _isLoading = true;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  AuthProvider() {
    loadToken();
  }

  Future<void> login(String token) async {
    _token = token;
    await _secureStorage.write(key: "token", value: token);
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    _token = null;
    await _secureStorage.delete(key: "token");
    notifyListeners();
  }

  Future<void> loadToken() async {
    _token = await _secureStorage.read(key: "token");
    _isLoading = false;
    notifyListeners();
  }
}