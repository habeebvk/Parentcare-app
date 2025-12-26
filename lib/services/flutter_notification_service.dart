import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // 🔹 Initialize notifications (call in main)
  static Future<void> initialize() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM TOKEN 👉 $token");

    // Request permission (Android 13+)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Android initialization
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });
  }

  // 🔔 Show notification
  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel',
      'Notifications',
      channelDescription: 'App notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }

  // 🔙 Background / terminated handler
  @pragma('vm-entry-point')
  static Future<void> firebaseBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    showNotification(message);
  }
}
