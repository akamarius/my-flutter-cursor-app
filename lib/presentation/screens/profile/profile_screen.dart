import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/user.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';
import 'package:my_flutter_app/services/notification_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: const Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, ref),
          ),
        ],
      ),
      body: _buildProfileContent(context),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authState = ref.watch(authStateProvider);

        return authState.when(
          data: (user) => _buildProfileContentWithUser(context, user),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Erreur: $error'),
          ),
        );
      },
    );
  }

  Widget _buildProfileContentWithUser(BuildContext context, User? user) {
    final displayName = user?.firstName != null && user?.lastName != null
        ? '${user!.firstName} ${user.lastName}'
        : user?.displayName ?? 'Utilisateur Démo';
    final email = user?.email ?? 'demo@example.com';
    final phoneNumber = user?.phoneNumber ?? 'Non renseigné';
    final role = user?.role == UserRole.assure ? 'Assuré' : 'Prospect';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête du profil
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                displayName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            /*IconButton(
                              icon: const Icon(Icons.edit),
                              tooltip: 'Modifier',
                              onPressed: () =>
                                  _showEditProfileDialog(context, user),
                            ),*/
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            role,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Modifier',
                    onPressed: () => _showEditProfileDialog(context, user),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Informations personnelles
          Text(
            'Informations personnelles',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          _buildInfoCard(context, [
            _buildInfoRow('Email', email, Icons.email),
            _buildInfoRow('Téléphone', phoneNumber, Icons.phone),
            _buildInfoRow('Rôle', role, Icons.badge),
          ]),

          const SizedBox(height: 24),

          // Actions rapides
          Text(
            'Actions rapides',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          _buildActionCard(context, [
            _buildActionRow(
              'Mes sinistres',
              'Consulter l\'historique',
              Icons.list,
              () => context.push('/claims'),
            ),
            _buildActionRow(
              'Nouveau sinistre',
              'Déclarer un sinistre',
              Icons.add_circle,
              () => context.push('/claims/new'),
            ),
            _buildActionRow(
              'Carte des bureaux',
              'Localiser les bureaux',
              Icons.map,
              () => context.push('/map'),
            ),
            _buildActionRow(
              'Cotation',
              'Obtenir un devis',
              Icons.calculate,
              () => context.push('/quote'),
            ),
            _buildActionRow(
              'Notifications de test',
              'Créer des notifications de test',
              Icons.notifications_active,
              () => _createTestNotifications(context, user),
            ),
            _buildActionRow(
              'Notifications',
              'Gérer les notifications',
              Icons.notifications,
              //() => _showNotificationSettings(context),
              () => context.push('/notifications'),
            ),
          ]),

          const SizedBox(height: 24),

          // Paramètres
          Text(
            'Paramètres',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          _buildActionCard(context, [
            _buildActionRow(
              'Sécurité',
              'Changer le mot de passe',
              Icons.security,
              () => _showSecuritySettings(context),
            ),
            _buildActionRow(
              'À propos',
              'Informations sur l\'app',
              Icons.info,
              () => _showAboutDialog(context),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<Widget> children) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  Widget _buildActionCard(BuildContext context, List<Widget> children) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildActionRow(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                await ref.read(authStateProvider.notifier).signOut();
                context.go('/login');

                Navigator.of(context).pop();
                context.go('/login');
              } catch (e) {
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Échec de la déconnexion'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              }
            },
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Paramètres de notifications'),
        content: const Text('Fonctionnalité en cours de développement'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSecuritySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Paramètres de sécurité'),
        content: const Text('Fonctionnalité en cours de développement'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Gestion Sinistres',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.security, size: 48),
      children: const [
        Text('Application de gestion de sinistres développée avec Flutter.'),
        SizedBox(height: 16),
        Text('© 2024 - Tous droits réservés'),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context, User? user) {
    showDialog(
      context: context,
      builder: (context) => EditProfileDialog(user: user),
    );
  }

  void _createTestNotifications(BuildContext context, User? user) async {
    if (user == null) return;

    try {
      final notificationService = NotificationService();
      await notificationService.createTestNotifications(user.id);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notifications de test créées !'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}

class EditProfileDialog extends StatefulWidget {
  final User? user;

  const EditProfileDialog({super.key, this.user});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;

  @override
  void initState() {
    super.initState();
    _firstName = widget.user?.firstName;
    _lastName = widget.user?.lastName;
    _email = widget.user?.email;
    _phone = widget.user?.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier le profil'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: const InputDecoration(labelText: 'Prénom'),
                onSaved: (val) => _firstName = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _lastName,
                decoration: const InputDecoration(labelText: 'Nom'),
                onSaved: (val) => _lastName = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (val) => _email = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _phone,
                decoration: const InputDecoration(labelText: 'Téléphone'),
                onSaved: (val) => _phone = val,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              // Appeler la logique de mise à jour
              final container = ProviderScope.containerOf(context);
              container.read(authStateProvider.notifier).updateProfileWithNames(
                    firstName: _firstName,
                    lastName: _lastName,
                    email: _email,
                    phoneNumber: _phone,
                  );

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil mis à jour !')),
              );
            }
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}
