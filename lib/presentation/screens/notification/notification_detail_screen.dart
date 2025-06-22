import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/presentation/providers/notification_provider.dart';
import 'package:my_flutter_app/domain/entities/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailScreen extends ConsumerWidget {
  final String notificationId;
  const NotificationDetailScreen({super.key, required this.notificationId});

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(notificationActionsProvider);
    final docStream = FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: docStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
              body: Center(child: Text('Notification introuvable')));
        }
        final notif = AppNotification.fromJson({
          'id': snapshot.data!.id,
          ...snapshot.data!.data() as Map<String, dynamic>,
        });
        // Marquer comme lue si non lue
        if (notif.status == NotificationStatus.unread) {
          repo.markAsRead(notificationId);
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Notification')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Icon(
                              switch (notif.type) {
                                NotificationType.claim => Icons.list,
                                NotificationType.reminder => Icons.alarm,
                                NotificationType.system => Icons.settings,
                                NotificationType.update => Icons.update,
                                _ => Icons.error,
                              },
                              color: Colors.blue),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notif.title,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Text(notif.timestamp.toString(),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ]),
                        const SizedBox(height: 16),
                        Text(notif.message,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 16),
                        if (notif.actionUrl != null &&
                            notif.actionUrl!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Ouvrir le lien associé'),
                            onPressed: () {
                              _launchUrl(notif.actionUrl!);
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
