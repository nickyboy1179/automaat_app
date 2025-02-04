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
  final FlutterSecureStorage _secureStorage = locator<FlutterSecureStorage>();

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
    String? storedId = await _secureStorage.read(key: "scheduled_notification");
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
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.show(id, title, body, notificationDetails());
    await _saveNotification(id, title, body, DateTime.now());
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
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    _saveNotification(id, title, body, scheduledDate);
  }

  Future<void> _saveNotification(
      int id,
      String title,
      String body,
      DateTime scheduledDate
      ) async {
    String? storedNotifications =
        await _secureStorage.read(key: 'scheduled_notifications');

    Map<String, dynamic> notificationsMap = {};

    if (storedNotifications != null && storedNotifications.isNotEmpty) {
      try {
        final decoded = jsonDecode(storedNotifications);
        if (decoded is Map<String, dynamic>) {
          notificationsMap = decoded;
        }
      } catch (e) {
        // Handle possible JSON decoding errors
        print("Error decoding notifications: $e");
      }
    }

    notificationsMap[id.toString()] = {
      "title": title,
      "body": body,
      "timestamp": scheduledDate.toIso8601String(),
    };

    await _secureStorage.write(
        key: 'scheduled_notifications', value: jsonEncode(notificationsMap)
    );
  }

  Future<Map<int, Map<String, dynamic>>> getScheduledNotifications() async {
    String? storedNotifications =
    await _secureStorage.read(key: 'scheduled_notifications');

    if (storedNotifications == null || storedNotifications.isEmpty) return {};

    try {
      final decoded = jsonDecode(storedNotifications);
      if (decoded is Map<String, dynamic>) {
        return decoded.map((key, value) => MapEntry(int.parse(key), value));
      }
    } catch (e) {
      print("Error decoding get notifications: $e");
    }

    return {}; // Return empty map if decoding fails
  }


  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);

    Map<int, Map<String, dynamic>> notificationsMap = await getScheduledNotifications();

    if (notificationsMap.containsKey(id)) {
      notificationsMap.remove(id);

      // Convert keys back to String before storing in secure storage
      final updatedJson = jsonEncode(
        notificationsMap.map((key, value) => MapEntry(key.toString(), value)),
      );

      await _secureStorage.write(key: 'scheduled_notifications', value: updatedJson);
    }
  }

  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
    await _secureStorage.delete(key: 'scheduled_notifications');
  }
}
