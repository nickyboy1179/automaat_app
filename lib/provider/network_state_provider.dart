import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkStateProvider with ChangeNotifier {
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  NetworkStateProvider() {
    _initConnectionListener();
  }

  void _initConnectionListener() {
    InternetConnection().onStatusChange.listen((status) {
      _isConnected = status == InternetStatus.connected;
      notifyListeners();
    });
  }
}
