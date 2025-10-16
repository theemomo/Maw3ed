import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationRepo {
  static onTap(NotificationResponse details) {}

  static FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    plugin.initialize(
      InitializationSettings(android: androidSettings),
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  static Future<void> showScheduledNotificationAtASpecificTime(
    String title,
    String description,
    DateTime date,
  ) async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        '0',
        'Event Notifications',
        channelDescription: 'Get a notification before your Maw\'ed',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
      ),
    );

    tz.initializeTimeZones();
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));

    plugin.zonedSchedule(
      0,
      title,
      description,
      tz.TZDateTime(
        tz.local,
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
      ),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'scheduled_payload_at_a_specific_time',
    );
    debugPrint("notification set to $date");
  }

  // cancel all notification
  static Future<void> cancelAllNotification() async {
    await plugin.cancelAll();
    debugPrint("🔕 All notifications cancelled");
  }

  // cancel notification
  static Future<void> cancelNotification(int id) async {
    await plugin.cancel(id);
    debugPrint("🔕 Notification $id cancelled");
  }
}
