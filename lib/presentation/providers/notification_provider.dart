import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/notification.dart';
import 'package:my_flutter_app/data/repositories/notification_repository_impl.dart';
import 'package:my_flutter_app/domain/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl();
});

final notificationsProvider =
    StreamProvider.family<List<AppNotification>, String>((ref, userId) {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getNotifications(userId);
});

final unreadNotificationsProvider =
    StreamProvider.family<List<AppNotification>, String>((ref, userId) {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getUnreadNotifications(userId);
});

final recentNotificationsProvider =
    StreamProvider.family<List<AppNotification>, String>((ref, userId) {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getRecentNotifications(userId, limit: 10);
});

final unreadCountProvider = StreamProvider.family<int, String>((ref, userId) {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getUnreadCount(userId);
});

final notificationActionsProvider = Provider<NotificationRepository>((ref) {
  return ref.watch(notificationRepositoryProvider);
});
