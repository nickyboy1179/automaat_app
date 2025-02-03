import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:automaat_app/locator.dart';

class NotificationService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  FlutterSecureStorage secureStorage = locator<FlutterSecureStorage>();

  bool get isInitialized => _initialized;

  NotificationService() {
    initNotificationService();
    _initializeTimeZones();
  }

  void _initializeTimeZones() {
    tz.initializeTimeZones(); // 🔹 Proper way to initialize
  }

  Future<void> initNotificationService() async {
    if (_initialized) return;

    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          'daily_channel_id',
          'Daily Notification Channel',
        ));

    _initialized = true;
  }

  Future<bool> isNotificationScheduled() async {
    String? storedId = await secureStorage.read(key: "scheduled_notification");
    return storedId != null;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableLights: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
        id, title, body, notificationDetails());
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
}) async {
    await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails(),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    _saveScheduledNotification(id, scheduledDate);
  }

  Future<void> _saveScheduledNotification(int id, DateTime scheduledDate) async {
    String? storedNotifications = await secureStorage.read(key: 'scheduled_notifications');
    Map<String, dynamic> notificationsMap = storedNotifications != null
        ? jsonDecode(storedNotifications)
        : {};

    notificationsMap[id.toString()] = scheduledDate.toIso8601String();

    await secureStorage.write(key:'scheduled_notifications', value: jsonEncode(notificationsMap));
  }

  Future<Map<int, DateTime>> getScheduledNotifications() async {
    String? storedNotifications = await secureStorage.read(key: 'scheduled_notifications');
    if (storedNotifications == null) return {};

    Map<String, dynamic> notificationsMap = jsonDecode(storedNotifications);
    return notificationsMap.map((key, value) => MapEntry(int.parse(key), DateTime.parse(value)));
  }

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);

    String? storedNotifications = await secureStorage.read(key: 'scheduled_notifications');
    if (storedNotifications != null) {
      Map<String, dynamic> notificationsMap = jsonDecode(storedNotifications);
      notificationsMap.remove(id.toString());
      await secureStorage.write(key: 'scheduled_notifications', value: jsonEncode(notificationsMap));
    }
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
    await secureStorage.delete(key: 'scheduled_notifications');
  }
}
