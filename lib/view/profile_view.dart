import 'package:automaat_app/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../locator.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final secureStorage = locator<FlutterSecureStorage>();


  void logOut(context) async {
    await secureStorage.delete(key: 'token');

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
          ),
            onPressed: () => logOut(context),
            child: Text("Uitloggen"),
        ),
      ),
    );
  }
}
