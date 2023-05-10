import 'dart:math';

import 'package:babi_cakes_mobile/src/features/core/models/event/event_message_view.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }
  
  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }
  
  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
  
  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification: _onSelectNotification;
          break;
          case NotificationResponseType.selectedNotificationAction: _selectedNotificationAction;
        }
      },
    );

  }

  _onSelectNotification(String? payload) {
    if(payload != null && payload.isNotEmpty) {
      //TODO: Aplicar rota ao clicar na notificação
    }
  }

  _selectedNotificationAction(String? payload) {

  }

  showNotification(EventMessageView event) {
    androidDetails = const AndroidNotificationDetails(
      'notification_events_x',
      'Notifications',
      channelDescription: 'Canal para notificações de eventos',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true
    );

    var id = Random();

    localNotificationsPlugin.show(
      id.nextInt(100), 
      event.title, 
      event.description, 
      NotificationDetails(android: androidDetails),
      payload: event.toJson().toString());
  }

  checkForNotification() async {
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if(details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.notificationResponse!.payload);
    }
  }
}