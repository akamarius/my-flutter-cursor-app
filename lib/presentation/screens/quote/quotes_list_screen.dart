import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';

class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({super.key});

  @override
  State<QuotesListScreen> createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  InsuranceType? _selectedInsuranceType;
  QuoteStatus? _selectedStatus;

  Stream<List<Quote>> getQuotesStream() {
    return FirebaseFirestore.instance
        .collection('quotes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Quote.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  List<Quote> _applyFilters(List<Quote> quotes) {
    return quotes.where((q) {
      final typeOk = _selectedInsuranceType == null ||
          q.insuranceType == _selectedInsuranceType;
      final statusOk = _selectedStatus == null || q.status == _selectedStatus;
      return typeOk && statusOk;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toutes les cotations')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<InsuranceType?>(
                    value: _selectedInsuranceType,
                    decoration: const InputDecoration(
                      labelText: 'Type d\'assurance',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Tous les types'),
                      ),
                      ...InsuranceType.values.map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.name),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedInsuranceType = value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<QuoteStatus?>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Statut',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Tous les statuts'),
                      ),
                      ...QuoteStatus.values.map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status.name),
                          )),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedStatus = value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<Quote>>(
              stream: getQuotesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erreur: \\${snapshot.error}'),
                  );
                }
                final quotes = _applyFilters(snapshot.data ?? []);
                if (quotes.isEmpty) {
                  return const Center(child: Text('Aucune cotation trouvée.'));
                }
                return ListView.separated(
                  itemCount: quotes.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final quote = quotes[index];
                    return ListTile(
                      title: Text('ID: \\${quote.id}'),
                      subtitle: Text(
                          'Type: \\${quote.insuranceType.name} | Statut: \\${quote.status.name}'),
                      trailing: Text(
                        quote.createdAt != null
                            ? '${quote.createdAt.day.toString().padLeft(2, '0')}/'
                                '${quote.createdAt.month.toString().padLeft(2, '0')}/'
                                '${quote.createdAt.year}'
                            : '',
                      ),
                      onTap: () {
                        // Remplace par ta navigation réelle
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                QuoteDetailScreen(quoteId: quote.id),
                          ),
                        );
                        // Ou avec go_router : context.push('/quote/details/${quote.id}');
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// À créer ou adapter selon ton projet
class QuoteDetailScreen extends StatelessWidget {
  final String quoteId;
  const QuoteDetailScreen({required this.quoteId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détail cotation $quoteId')),
      body: Center(child: Text('Détail de la cotation $quoteId')),
    );
  }
}
