import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/entities/notification.dart';
import 'package:my_flutter_app/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FirebaseFirestore _firestore;

  NotificationRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<AppNotification>> getNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return AppNotification.fromJson({
                'id': doc.id,
                ...data,
              });
            }).toList());
  }

  @override
  Stream<List<AppNotification>> getUnreadNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: NotificationStatus.unread.name)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return AppNotification.fromJson({
                'id': doc.id,
                ...data,
              });
            }).toList());
  }

  @override
  Stream<List<AppNotification>> getRecentNotifications(String userId,
      {int limit = 10}) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return AppNotification.fromJson({
                'id': doc.id,
                ...data,
              });
            }).toList());
  }

  @override
  Stream<int> getUnreadCount(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: NotificationStatus.unread.name)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(notificationId)
          .update({'status': NotificationStatus.read.name});
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    try {
      final batch = _firestore.batch();
      final unreadNotifications = await _firestore
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: NotificationStatus.unread.name)
          .get();

      for (final doc in unreadNotifications.docs) {
        batch.update(doc.reference, {'status': NotificationStatus.read.name});
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to mark all notifications as read: $e');
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).delete();
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  @override
  Future<void> deleteReadNotifications(String userId) async {
    try {
      final batch = _firestore.batch();
      final readNotifications = await _firestore
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: NotificationStatus.read.name)
          .get();

      for (final doc in readNotifications.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete read notifications: $e');
    }
  }

  @override
  Future<void> createNotification(AppNotification notification) async {
    try {
      final docRef = _firestore.collection('notifications').doc();
      final notificationData = notification.copyWith(id: docRef.id).toJson();
      notificationData
          .remove('id'); // Supprimer l'id car il sera l'ID du document

      await docRef.set(notificationData);
    } catch (e) {
      throw Exception('Failed to create notification: $e');
    }
  }

  @override
  Future<void> updateNotification(AppNotification notification) async {
    try {
      final notificationData = notification.toJson();
      notificationData.remove('id'); // Supprimer l'id car il est dans l'URL

      await _firestore
          .collection('notifications')
          .doc(notification.id)
          .update(notificationData);
    } catch (e) {
      throw Exception('Failed to update notification: $e');
    }
  }
}
