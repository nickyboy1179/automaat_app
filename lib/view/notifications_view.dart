import 'package:automaat_app/provider/network_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import '../service/notification_service.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  NotificationService notifService = locator<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: ElevatedButton(
            onPressed: () async {
              notifService.showNotification(
                title: "Test notificatie",
                body: "Deze app is echt gewelidg man!",
              );
            },
            child: const Text("send notification")),
      ),
    );
  }
}
