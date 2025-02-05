import 'package:automaat_app/model/retrofit/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:automaat_app/service/locator.dart';

class NetworkStateProvider with ChangeNotifier {
  final RestClient _restClient = locator<RestClient>();

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  NetworkStateProvider() {
    _initConnectionListener();
  }

  void _initConnectionListener() {
    InternetConnection().onStatusChange.listen((status) async {
      if (status == InternetStatus.connected) {
        await _checkBackendConnectivity();
      } else {
        _isConnected = false;
        notifyListeners();
      }
    });
  }

  Future<void> _checkBackendConnectivity() async {
    try {
      await _restClient.getAuth();
      _isConnected = true;
    } catch (_) {
      _isConnected = false;
    }
    notifyListeners();
  }
}
