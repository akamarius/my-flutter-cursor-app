import 'package:my_flutter_app/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<Quote> requestQuote(QuoteRequest request);
  Future<List<Quote>> getUserQuotes(String userId);
  Future<Quote> getQuoteById(String quoteId);
} 