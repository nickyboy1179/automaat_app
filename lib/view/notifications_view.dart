import 'package:automaat_app/component/confirm_button.dart';
import 'package:automaat_app/controller/notifications_controller.dart';
import 'package:automaat_app/service/notification_service.dart';
import 'package:flutter/material.dart';

import '../service/locator.dart';

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

  Future<void> _refresh() async {
    await controller.loadNotifications();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meldingen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.loadNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.3,
                    ),
                    const Center(
                      child: Text("Geen meldingen"),
                    ),
                  ]),
                ),
              );
            } else {
              Map<int, Map<String, dynamic>> pastNotifications = snapshot.data!;
              return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: pastNotifications.keys.length,
                    itemBuilder: (context, index) {
                      int id = pastNotifications.keys.elementAt(index);
                      Map<String, dynamic> notification =
                          pastNotifications[id]!;
                      return Dismissible(
                        key: Key(id.toString()),
                        onDismissed: (_) async {
                          await controller.deleteNotification(id);
                          await controller.loadNotifications();
                          setState(() {});
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          child: ListTile(
                            leading: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary),
                            title: Text(notification["title"]),
                            subtitle: Text(notification["body"]),
                            trailing: Text(notification["timestamp"].split('T').first),
                          ),
                        ),
                      );


                    },
                  ),
              );
            }
          }),
    );
  }
}
