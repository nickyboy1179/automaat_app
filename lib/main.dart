import 'package:automaat_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:automaat_app/view/login.dart';


void main() {
  setupLocator();
  runApp ( AutomaatApp() );
}

class AutomaatApp extends StatelessWidget {
  const AutomaatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login(),
      ),
    );
  }
}
