import 'package:my_flutter_app/domain/entities/notification.dart';

abstract class NotificationRepository {
  /// Récupère toutes les notifications d'un utilisateur
  Stream<List<AppNotification>> getNotifications(String userId);

  /// Récupère les notifications non lues d'un utilisateur
  Stream<List<AppNotification>> getUnreadNotifications(String userId);

  /// Récupère les 10 dernières notifications d'un utilisateur
  Stream<List<AppNotification>> getRecentNotifications(String userId,
      {int limit = 10});

  /// Récupère le nombre de notifications non lues
  Stream<int> getUnreadCount(String userId);

  /// Marque une notification comme lue
  Future<void> markAsRead(String notificationId);

  /// Marque toutes les notifications d'un utilisateur comme lues
  Future<void> markAllAsRead(String userId);

  /// Supprime une notification
  Future<void> deleteNotification(String notificationId);

  /// Supprime toutes les notifications lues d'un utilisateur
  Future<void> deleteReadNotifications(String userId);

  /// Crée une nouvelle notification
  Future<void> createNotification(AppNotification notification);

  /// Met à jour une notification
  Future<void> updateNotification(AppNotification notification);
}
