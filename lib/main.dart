import 'package:automaat_app/provider/auth_provider.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/service/notification_service.dart';
import 'package:automaat_app/theme/theme.dart';
import 'package:automaat_app/view/navigation_view_v2.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/locator.dart';
import 'package:automaat_app/view/login_view.dart';
import 'package:provider/provider.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await locator.allReady();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NetworkStateProvider(),
      ),
      ChangeNotifierProvider(
          create: (context) => AuthProvider(),
      ),
    ],
    child: AutomaatApp(),
  ));
}

class AutomaatApp extends StatelessWidget {
  const AutomaatApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    if (auth.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider auth, Widget? child) {
        return MaterialApp(
          title: 'Automaat',
          theme: lightMode,
          darkTheme: darkMode,
          home: auth.isAuthenticated ? NavigationViewV2() : Login()
        );
      },
    );
  }
}

