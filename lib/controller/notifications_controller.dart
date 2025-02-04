import 'package:automaat_app/locator.dart';
import 'package:automaat_app/service/notification_service.dart';

class NotificationsController {
  final NotificationService _notiService = locator<NotificationService>();

  Future<Map<int, Map<String, dynamic>>> loadNotifications() async {
    Map<int, Map<String, dynamic>> notifications = await _notiService.getScheduledNotifications();
    Map<int, Map<String, dynamic>> pastNotifications = {};

    notifications.forEach((k, v) {
      DateTime notificationDateTime = DateTime.parse(v["timestamp"]);
      if (notificationDateTime.compareTo(DateTime.now()) < 0) {
        pastNotifications[k] = v;
      }
    });

    return pastNotifications;
  }

  Future<void> deleteNotification(int id) async {
    await _notiService.cancelNotification(id);
  }
}