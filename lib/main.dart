import 'package:flutter/material.dart';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/view/navigation_view.dart';
import 'package:automaat_app/view/login_view.dart';
import 'package:automaat_app/common/shared_widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  setupLocator();
  runApp(AutomaatApp());
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
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return Navigation();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
