// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:new_music_app/firebase_options.dart';
// /// A manager class to handle Firebase notifications in the application.
// class FirebaseNotificationManager {
//   static final _notification = FlutterLocalNotificationsPlugin();
//
//   /// Initializes the notification manager, sets up Firebase messaging,
//   /// subscribes to topic, and configures foreground/background handlers.
//   Future<FirebaseNotificationManager> init() async {
//     // Initialize local notifications
//     await _notification.initialize(
//       const InitializationSettings(
//         android: AndroidInitializationSettings('jaylogo'),
//         iOS: DarwinInitializationSettings(),
//       ),
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         // Optional: Handle tap on notification
//         print("🔗 Notification tapped: ${response.payload}");
//       },
//     );
//
//     // Request notification permissions
//     // await FirebaseMessaging.instance.requestPermission(
//     //   alert: true,
//     //   badge: true,
//     //   sound: true,
//     // );
//
//     // Configure foreground notification behavior
//     // await FirebaseMessaging.instance
//     //     .setForegroundNotificationPresentationOptions(
//     //   alert: true,
//     //   badge: true,
//     //   sound: true,
//     // );
//
//     // Subscribe to topic
//     await FirebaseMessaging.instance.subscribeToTopic('jaylyricsNotification');
//     print("✅ Subscribed to topic: jaylyricsNotification");
//
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((message) async {
//       final title = message.notification?.title ?? message.data['title'];
//       final body = message.notification?.body ?? message.data['body'];
//
//       const notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "1",
//           "jrtransportation",
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(),
//       );
//
//       await _notification.show(
//         1001,
//         title,
//         body,
//         notificationDetails,
//         payload: jsonEncode(message.data),
//       );
//
//       print("📩 Foreground Notification:");
//       print("🔔 Title: $title");
//       print("📝 Body: $body");
//       print("📦 Data: ${jsonEncode(message.data)}");
//       print("🕒 Timestamp: ${DateFormat('MMddHHmm').format(DateTime.now())}");
//     });
//
//     return this;
//   }
//
// }
// @pragma('vm:entry-point')
// Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   if (message.notification == null && message.data.isNotEmpty) {
//     final _notification = FlutterLocalNotificationsPlugin();
//
//     const notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         '1',
//         'jrtransportation',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//
//     await _notification.show(
//       1001,
//       message.data['title'] ?? '',
//       message.data['body'] ?? '',
//       notificationDetails,
//       payload: jsonEncode(message.data),
//     );
//   }
//
//   print("📩 Background Notification:");
//   print("🔔 Title: ${message.data['title'] ?? message.notification?.title}");
//   print("📝 Body: ${message.data['body'] ?? message.notification?.body}");
//   print("📦 Data: ${jsonEncode(message.data)}");
//   print("🕒 Timestamp: ${DateFormat('MMddHHmm').format(DateTime.now())}");
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_music_app/firebase_options.dart';
// import 'package:djmachado1/firebase_options.dart';

/// A manager class to handle Firebase notifications in the application.
class FirebaseNotificationManager {
  static final _notification = FlutterLocalNotificationsPlugin();

  /// Initializes the notification manager, sets up Firebase messaging,
  /// and configures foreground and background notification handling.
  ///
  /// Returns a future that resolves with the current [FirebaseNotificationManager] instance.
  Future<FirebaseNotificationManager> init() async {
    _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('siskologo'),
      iOS: DarwinInitializationSettings(),
    ));

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings status = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance.subscribeToTopic('djjoanNotification');
    print("✅ Subscribed to topic: jaylyricsNotification");
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) async {
      if (Platform.isAndroid) {
        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            "1", 'jrtransportation',
            importance: Importance.max, priority: Priority.high);
        var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics,
        );
        await _notification.show(
          1001,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
        );

        // Debugging output
        print(message.notification?.title);
        print(message.notification?.body);
        print(jsonEncode(message.data));
        print(int.parse(DateFormat('MMddHHmm').format(DateTime.now())));
      }
    });

    return this;
  }

  /// Retrieves the Firebase token for the device.
  ///
  /// Returns a future that resolves with the Firebase token as a string.
  Future<String> getToken() async {
    return await FirebaseMessaging.instance.getToken().then((value) {
      print("this is fcm $value");
      return Future.value(value ?? '');
    }).catchError((error) {
      return Future.value('');
    });
  }
}

/// Background message handler for Firebase notifications.
@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (message.notification == null && message.data.isNotEmpty) {
    final notification = FlutterLocalNotificationsPlugin();

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        '1',
        'jrtransportation',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await notification.show(
      1001,
      message.data['title'] ?? '',
      message.data['body'] ?? '',
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  print("📩 Background Notification:");
  print("🔔 Title: ${message.data['title'] ?? message.notification?.title}");
  print("📝 Body: ${message.data['body'] ?? message.notification?.body}");
  print("📦 Data: ${jsonEncode(message.data)}");
  print("🕒 Timestamp: ${DateFormat('MMddHHmm').format(DateTime.now())}");
}