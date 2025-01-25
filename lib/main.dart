import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/provider/theme_provider.dart';
import 'package:automaat_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/view/navigation_view.dart';
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
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
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
        theme: context.watch<ThemeProvider>().themeData,
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
