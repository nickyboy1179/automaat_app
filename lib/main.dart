import 'package:flutter/material.dart';
import 'package:automaat_app/view/login.dart';
import 'package:automaat_app/view/navigation.dart';


void main() {
  runApp ( AutomaatApp() );
}

class AutomaatApp extends StatelessWidget {
  const AutomaatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}
