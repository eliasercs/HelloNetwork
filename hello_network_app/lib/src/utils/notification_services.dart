import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("app_icon");

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationPlugin.initialize(initializationSettings);
}

Future<void> showNotification(String? date) async {
  var d = tz.TZDateTime.parse(tz.local, date!);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails("holamundo", "hello_network_app",
          importance: Importance.max,
          priority: Priority.high,
          ticker: "ticker");
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  /*
  await flutterLocalNotificationPlugin.show(1, "Título de la notificación",
      "Tienes tarea pendiente", notificationDetails);
  */

  String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  //tz.initializeTimeZones();

  tz.setLocalLocation(tz.getLocation(currentTimeZone));

  var uiLocalNotificationDateInterpretation =
      UILocalNotificationDateInterpretation.absoluteTime;
  await flutterLocalNotificationPlugin.zonedSchedule(1, "Prueba",
      "Te quiero mucho", tz.TZDateTime.from(d, tz.local), notificationDetails,
      uiLocalNotificationDateInterpretation:
          uiLocalNotificationDateInterpretation,
      matchDateTimeComponents: DateTimeComponents.time);
}
