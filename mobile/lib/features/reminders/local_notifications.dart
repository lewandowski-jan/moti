import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart' as ftz;
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  const LocalNotifications(
    this.plugin,
  );

  final FlutterLocalNotificationsPlugin plugin;

  void init() {
    initializeTimeZones();

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
        id,
        title,
        body,
        payload,
      ) {
        // no-op
      },
    );
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    plugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          _onNotificationOpenedInBackground,
      onDidReceiveNotificationResponse: (response) {
        // no-op
      },
    );

    if (Platform.isAndroid) {
      plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(
          const AndroidNotificationChannel(
            'moti_reminders_channel',
            'Moti reminders',
          ),
        );
    }
  }

  @pragma('vm:entry-point')
  static void _onNotificationOpenedInBackground(NotificationResponse reponse) {
    if (kDebugMode) {
      print('Notification opened in background: $reponse');
    }
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final ios = plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final permissions = await ios?.checkPermissions();
      final enabled = permissions?.isEnabled ?? false;
      final alert = permissions?.isAlertEnabled ?? false;
      if (enabled && alert) {
        return true;
      }

      final result = await plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
          );

      if (result ?? false) {
        return true;
      }
    }

    final android = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final enabled = await android?.areNotificationsEnabled() ?? false;
    final exact = await android?.canScheduleExactNotifications() ?? false;
    if (enabled && exact) {
      return true;
    }

    final enableResult =
        await android?.requestNotificationsPermission() ?? false;
    final exactResult = await android?.requestExactAlarmsPermission() ?? false;

    return enableResult && exactResult;
  }

  Future<void> rescheduleNotifications(String title, ValueGetter<String> generator) async {
    await plugin.cancelAll();

    final timezone = await ftz.FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));

    final notifications = [
      (generator(), const Duration(days: 1)),
      (generator(), const Duration(days: 1, hours: 1)),
      (generator(), const Duration(days: 1, hours: 2)),
      (generator(), const Duration(days: 2)),
      (generator(), const Duration(days: 2, hours: 1)),
      (generator(), const Duration(days: 3)),
    ];

    for (var i = 0; i < notifications.length; i++) {
      final (body, after) = notifications[i];

      await scheduleNotification(
        id: i,
        title: title,
        body: body,
        after: after,
      );
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required Duration after,
  }) async {
    final date = tz.TZDateTime.now(tz.local).add(after);

    await plugin.zonedSchedule(
      id,
      title,
      body,
      date,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'moti_reminders_channel',
          'Moti reminders',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
