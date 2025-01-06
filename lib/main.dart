import 'package:flutter/material.dart';
import 'package:automaat_app/view/login.dart';


void main() {
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
