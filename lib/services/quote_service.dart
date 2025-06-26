import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';

class QuoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'quotes';

  // Créer une nouvelle cotation
  Future<Quote> createQuote(QuoteRequest request) async {
    try {
      final docRef = await _firestore.collection(_collection).add({
        'userId': 'current_user', // TODO: Récupérer l'ID utilisateur connecté
        'insuranceType': request.insuranceType.name,
        'data': request.data,
        'notes': request.notes,
        'status': QuoteStatus.pending.name,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      final doc = await docRef.get();
      return _fromFirestore(doc);
    } catch (e) {
      throw Exception('Erreur lors de la création de la cotation: $e');
    }
  }

  // Récupérer une cotation par ID
  Future<Quote?> getQuoteById(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return _fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Erreur lors de la récupération de la cotation: $e');
    }
  }

  // Récupérer toutes les cotations avec pagination et filtres
  Future<List<Quote>> getQuotes({
    int limit = 10,
    DocumentSnapshot? lastDocument,
    QuoteStatus? status,
    InsuranceType? insuranceType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      Query query = _firestore.collection(_collection);

      // Appliquer les filtres
      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      if (insuranceType != null) {
        query = query.where('insuranceType', isEqualTo: insuranceType.name);
      }

      if (startDate != null) {
        query = query.where('createdAt', isGreaterThanOrEqualTo: startDate);
      }

      if (endDate != null) {
        query = query.where('createdAt', isLessThanOrEqualTo: endDate);
      }

      // Trier par date de création (plus récent en premier)
      query = query.orderBy('createdAt', descending: true);

      // Appliquer la pagination
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      query = query.limit(limit);

      final querySnapshot = await query.get();
      return querySnapshot.docs.map((doc) => _fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des cotations: $e');
    }
  }

  // Mettre à jour le statut d'une cotation
  Future<void> updateQuoteStatus(String id, QuoteStatus status) async {
    try {
      await _firestore.collection(_collection).doc(id).update({
        'status': status.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du statut: $e');
    }
  }

  // Ajouter une réponse à une cotation
  Future<void> addQuoteResponse(
      String id, Map<String, dynamic> response) async {
    try {
      await _firestore.collection(_collection).doc(id).update({
        'responseData': response,
        'status': QuoteStatus.completed.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout de la réponse: $e');
    }
  }

  // Supprimer une cotation
  Future<void> deleteQuote(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Erreur lors de la suppression de la cotation: $e');
    }
  }

  // Obtenir les statistiques des cotations
  Future<Map<String, dynamic>> getQuoteStatistics() async {
    try {
      final querySnapshot = await _firestore.collection(_collection).get();
      final quotes =
          querySnapshot.docs.map((doc) => _fromFirestore(doc)).toList();

      // Statistiques par statut
      final statusStats = <String, int>{};
      for (final status in QuoteStatus.values) {
        statusStats[status.name] =
            quotes.where((q) => q.status == status).length;
      }

      // Statistiques par type d'assurance
      final insuranceTypeStats = <String, int>{};
      for (final type in InsuranceType.values) {
        insuranceTypeStats[type.name] =
            quotes.where((q) => q.insuranceType == type).length;
      }

      // Statistiques par mois (12 derniers mois)
      final monthlyStats = <String, int>{};
      final now = DateTime.now();
      for (int i = 0; i < 12; i++) {
        final month = DateTime(now.year, now.month - i, 1);
        final monthKey =
            '${month.year}-${month.month.toString().padLeft(2, '0')}';
        monthlyStats[monthKey] = quotes.where((q) {
          final quoteDate = q.createdAt;
          return quoteDate.year == month.year && quoteDate.month == month.month;
        }).length;
      }

      return {
        'total': quotes.length,
        'statusStats': statusStats,
        'insuranceTypeStats': insuranceTypeStats,
        'monthlyStats': monthlyStats,
      };
    } catch (e) {
      throw Exception('Erreur lors de la récupération des statistiques: $e');
    }
  }

  // Rechercher des cotations par texte
  Future<List<Quote>> searchQuotes(String searchTerm) async {
    try {
      // Recherche simple par ID ou notes
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('notes', isGreaterThanOrEqualTo: searchTerm)
          .where('notes', isLessThan: '$searchTerm\uf8ff')
          .get();

      return querySnapshot.docs.map((doc) => _fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la recherche: $e');
    }
  }

  // Méthode helper pour convertir un DocumentSnapshot en Quote
  Quote _fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['createdAt'] as Timestamp;
    final updatedTimestamp = data['updatedAt'] as Timestamp?;

    return Quote(
      id: doc.id,
      userId: data['userId'] ?? '',
      insuranceType: InsuranceType.values.firstWhere(
        (e) => e.name == data['insuranceType'],
      ),
      status: QuoteStatus.values.firstWhere(
        (e) => e.name == data['status'],
      ),
      requestData: Map<String, dynamic>.from(data['data'] ?? {}),
      responseData: data['responseData'] != null
          ? Map<String, dynamic>.from(data['responseData'])
          : null,
      createdAt: timestamp.toDate(),
      updatedAt: updatedTimestamp?.toDate(),
      notes: data['notes'],
      estimatedAmount: data['estimatedAmount']?.toDouble(),
      assignedAgent: data['assignedAgent'],
    );
  }

  Future<List<Quote>> getUserQuotes(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => _fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des cotations: $e');
    }
  }
}
