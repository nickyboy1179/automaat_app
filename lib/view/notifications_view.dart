import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/controller/notifications_controller.dart';
import 'package:automaat_app/service/notification_service.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  NotificationsViewState createState() => NotificationsViewState();
}

class NotificationsViewState extends State<NotificationsView> {
  NotificationsController controller = NotificationsController();
  NotificationService notificationService = locator<NotificationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Past Notifications")),
        body: Column(
          children: [
            ConfirmButton(
                text: "Stuur melding!",
                color: Theme.of(context).colorScheme.primary,
                onColor: Theme.of(context).colorScheme.onPrimary,
                onPressed: () {
                  notificationService.showNotification(
                      title: "Melding pik!",
                      body: "Wat een gribus app heb jij gemaakt zeg!");
                }
            ),
            FutureBuilder(
              future: controller.loadNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error ${snapshot.error}"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No past notifications"),
                  );
                } else {
                  Map<int, Map<String, dynamic>> pastNotifications = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: pastNotifications.keys.length,
                      itemBuilder: (context, index) {
                        int id = pastNotifications.keys.elementAt(index);
                        Map<String, dynamic> notification = pastNotifications[id]!;
                        return Dismissible(
                          key: Key(id.toString()),
                          onDismissed: (_) async => {
                            await controller.deleteNotification(id),
                            await controller.loadNotifications(),
                            setState(() {})
                          },
                          background: Container(color: Colors.red),
                          child: ListTile(
                            title: Text(notification["title"]),
                            subtitle: Text(notification["body"]),
                            trailing:
                                Text(notification["timestamp"].split('T').first),
                          ),
                        );
                      },
                    ),
                  );
                }
              }
          ),
    ]
        )
    );
  }
}
