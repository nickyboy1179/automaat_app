import 'package:automaat_app/controller/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:automaat_app/component/confirm_button.dart';
import '../locator.dart';
import '../main.dart';
import 'login_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final secureStorage = locator<FlutterSecureStorage>();
  final ProfileViewmodel profileViewmodel = ProfileViewmodel();

  void logOut(context) async {
    await secureStorage.delete(key: 'token');

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()), // Replace with LoginScreen
            (route) => false, // Remove all previous routes
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConfirmButton(
              text: 'Uitloggen',
              color: Theme.of(context).colorScheme.primary,
              onColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                logOut(context);
              },
            ),
          ],
        )
      )
    );
  }
}
