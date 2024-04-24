import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  const LocalNotifications(this.plugin);

  final FlutterLocalNotificationsPlugin plugin;

  void init() {
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
        // TODO: Handle notification
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
        // TODO: Handle notification response
      },
    );
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

    final enableResult = await android?.requestNotificationsPermission() ?? false;
    final exactResult = await android?.requestExactAlarmsPermission() ?? false;

    return enableResult && exactResult;
  }

  Future<void> scheduleNotifications() async {
    // TODO: Implement
  }
}
