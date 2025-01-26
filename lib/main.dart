import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/view/login_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NetworkStateProvider(),
      ),
    ],
    child: const AutomaatApp(),
  ));
}

class AutomaatApp extends StatelessWidget {
  const AutomaatApp({super.key});

  Future<bool> isLoggedIn() async {
    final secureStorage = locator<FlutterSecureStorage>();
    final String? token = await secureStorage.read(key: 'token');
    // Wait until DI container has finished initializing.
    await locator.allReady();
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automaat ride',
      theme: lightMode,
      darkTheme: darkMode,
      home: Login(),
    );
  }
}
