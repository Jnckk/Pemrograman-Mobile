import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initPushNotification() async {
    // Izinkan pengguna memberikan izin untuk pemberitahuan
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Dapatkan token messaging
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }
}
