import 'package:automaat_app/controller/profile_viewmodel.dart';
import 'package:automaat_app/view/developer_options_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/auth_provider.dart';


class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileViewmodel profileViewmodel = ProfileViewmodel();

  void logOut(BuildContext context) async {
    await context.read<AuthProvider>().logout(context);
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
            SizedBox(height: 16,),
            ConfirmButton(
              text: 'Developer opties',
              color: Theme.of(context).colorScheme.primary,
              onColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeveloperOptionsView(),
                  ),
                );
              },
            ),
          ],
        )
      )
    );
  }
}
