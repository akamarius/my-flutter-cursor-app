import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/providers/notification_provider.dart';
import 'package:my_flutter_app/domain/entities/notification.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class NotificationsListScreen extends ConsumerStatefulWidget {
  const NotificationsListScreen({super.key});

  @override
  ConsumerState<NotificationsListScreen> createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState
    extends ConsumerState<NotificationsListScreen> {
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final user = authState.value;
    final userId = user?.id ?? '';
    final notificationsAsync = filter == 'unread'
        ? ref.watch(unreadNotificationsProvider(userId))
        : ref.watch(notificationsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => filter = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('Toutes')),
              const PopupMenuItem(value: 'unread', child: Text('Non lues')),
            ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(notificationsProvider(userId).future);
        },
        child: notificationsAsync.when(
          data: (notifications) => notifications.isEmpty
              ? const Center(child: Text('Aucune notification'))
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: notif.status == NotificationStatus.unread
                            ? const Icon(Icons.markunread, color: Colors.blue)
                            : const Icon(Icons.drafts, color: Colors.grey),
                        title: Text(notif.title),
                        subtitle: Text(
                          notif.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: notif.status == NotificationStatus.unread
                            ? const Icon(Icons.circle,
                                color: Colors.red, size: 10)
                            : null,
                        onTap: () => context.push('/notifications/${notif.id}'),
                      ),
                    );
                  },
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Erreur: $e')),
        ),
      ),
    );
  }
}
