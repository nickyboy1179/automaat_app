import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/auth_provider.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/view/forgot_password_view.dart';

class DeveloperOptionsView extends StatelessWidget {
  const DeveloperOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Developer options"),
      ),
      body: Column(
        children: [
          Text(
              "Is authenticated: ${context.watch<AuthProvider>().isAuthenticated.toString()}"),
          const SizedBox(
            height: 16,
          ),
          Text(
              "Is connected: ${context.watch<NetworkStateProvider>().isConnected.toString()}"),
          const SizedBox(
            height: 16,
          ),
          ConfirmButton(
              text: "Naar wachtwoord vergeten",
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordView(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
