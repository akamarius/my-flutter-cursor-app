import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final FirebaseFirestore _firestore;

  QuoteRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Quote> requestQuote(QuoteRequest request) async {
    try {
      final docRef = _firestore.collection('quotes').doc();
      final quote = Quote(
        id: docRef.id,
        userId: request.userId,
        insuranceType: request.insuranceType,
        requestData: request.data,
        createdAt: DateTime.now(),
        status: QuoteStatus.pending,
      );
      await docRef.set(quote.toJson());
      return quote;
    } catch (e) {
      throw Exception('Failed to request quote: $e');
    }
  }

  @override
  Future<List<Quote>> getUserQuotes(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('quotes')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => Quote.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get user quotes: $e');
    }
  }

  @override
  Future<Quote> getQuoteById(String quoteId) async {
    try {
      final doc = await _firestore.collection('quotes').doc(quoteId).get();
      if (!doc.exists) {
        throw Exception('Quote not found');
      }
      return Quote.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get quote: $e');
    }
  }
}
