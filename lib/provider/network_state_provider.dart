import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkStateProvider with ChangeNotifier {
  bool isConnected = true;

  // bool get isConnected => _isConnected;

  NetworkStateProvider() {
    _initConnectionListener();
  }

  void _initConnectionListener() {
    InternetConnection().onStatusChange.listen((status) {
      isConnected = status == InternetStatus.connected;
      notifyListeners();
    });
  }
}
