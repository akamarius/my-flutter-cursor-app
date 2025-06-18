import 'package:my_flutter_app/data/datasources/quote_api.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteApi _api;

  QuoteRepositoryImpl({QuoteApi? api}) : _api = api ?? MockQuoteApi();

  @override
  Future<Quote> requestQuote(QuoteRequest request) async {
    try {
      return await _api.requestQuote(request);
    } catch (e) {
      throw Exception('Failed to request quote: $e');
    }
  }

  @override
  Future<List<Quote>> getUserQuotes(String userId) async {
    try {
      return await _api.getUserQuotes(userId);
    } catch (e) {
      throw Exception('Failed to get user quotes: $e');
    }
  }

  @override
  Future<Quote> getQuoteById(String quoteId) async {
    try {
      return await _api.getQuoteById(quoteId);
    } catch (e) {
      throw Exception('Failed to get quote: $e');
    }
  }
} 