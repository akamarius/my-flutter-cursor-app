import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Request permission for iOS
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    await _showLocalNotification(
      title: message.notification?.title ?? 'Nouvelle notification',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
    );
  }

  Future<void> _handleNotificationTap(RemoteMessage message) async {
    // Handle notification tap when app is in background
    // You can navigate to specific screen based on the data
    print('Notification tapped: ${message.data}');
  }

  Future<void> _onNotificationTap(NotificationResponse response) async {
    // Handle local notification tap
    print('Local notification tapped: ${response.payload}');
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Crée des notifications de test pour l'utilisateur
  Future<void> createTestNotifications(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final notifications = [
      {
        'userId': 'ZaGt6Hxn1Uey3Uqx8tBXzSsVxI33',
        'title': 'Nouveau sinistre déclaré',
        'message': 'Votre sinistre #12345 a été enregistré avec succès.',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'unread',
        'type': 'claim',
        'actionUrl': '/claims/12345',
      },
      {
        'userId': 'ZaGt6Hxn1Uey3Uqx8tBXzSsVxI33',
        'title': 'Mise à jour du statut',
        'message': 'Le statut de votre sinistre #12345 a été mis à jour.',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'unread',
        'type': 'update',
        'actionUrl': '/claims/12345',
      },
      {
        'userId': 'ZaGt6Hxn1Uey3Uqx8tBXzSsVxI33',
        'title': 'Rappel de rendez-vous',
        'message': 'N\'oubliez pas votre rendez-vous demain à 14h00.',
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'read',
        'type': 'reminder',
      },
    ];

    final batch = firestore.batch();
    for (final notification in notifications) {
      final docRef = firestore.collection('notifications').doc();
      batch.set(docRef, notification);
    }
    await batch.commit();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print('Handling background message: ${message.messageId}');
}
