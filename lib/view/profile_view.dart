import 'package:automaat_app/common/static_elements.dart';
import 'package:automaat_app/controller/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/component/confirm_button.dart';
import '../locator.dart';
import '../main.dart';
import '../model/rest_model/about_me_model.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final secureStorage = locator<FlutterSecureStorage>();
  final ProfileViewmodel profileViewmodel = ProfileViewmodel();

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
