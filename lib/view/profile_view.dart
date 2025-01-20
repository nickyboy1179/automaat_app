import 'package:automaat_app/common/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../locator.dart';
import '../main.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final secureStorage = locator<FlutterSecureStorage>();


  void logOut(context) async {
    await secureStorage.delete(key: 'token');

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AutomaatApp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: SharedWidgets.automaatConfirmButtonStyle,
          onPressed: () => logOut(context),
          child: Text(
            "Uitloggen",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
