import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/provider/auth_provider.dart';
import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:automaat_app/view/forgot_password_view.dart';

import 'package:automaat_app/service/locator.dart';
import 'package:automaat_app/service/notification_service.dart';

class DeveloperOptionsView extends StatelessWidget {
  const DeveloperOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    NotificationService notificationService = locator<NotificationService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer options"),
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
          const SizedBox(height: 16),
          ConfirmButton(
              text: "Stuur melding!",
              color: Theme.of(context).colorScheme.primary,
              onColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () {
                notificationService.showNotification(
                    title: "Melding!",
                    body: "Wat een gribus app heb jij gemaakt zeg!");
              }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
