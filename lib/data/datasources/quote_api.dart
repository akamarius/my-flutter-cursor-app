import 'package:my_flutter_app/domain/entities/quote.dart';

// Interface simple pour l'API de cotation
abstract class QuoteApi {
  Future<Quote> requestQuote(QuoteRequest request);
  Future<List<Quote>> getUserQuotes(String userId);
  Future<Quote> getQuoteById(String quoteId);
}

// Mock implementation
class MockQuoteApi implements QuoteApi {
  @override
  Future<Quote> requestQuote(QuoteRequest request) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock calculation logic
    double baseAmount = 500.0;
    if (request.year < 2010) baseAmount += 200.0;
    if (request.hasAccidents) baseAmount += 300.0;

    return Quote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId:
          'ZaGt6Hxn1Uey3Uqx8tBXzSsVxI33', // This will be replaced by the actual user ID
      brand: request.brand,
      model: request.model,
      year: request.year,
      hasAccidents: request.hasAccidents,
      amount: baseAmount,
      createdAt: DateTime.now(),
      notes: request.notes,
    );
  }

  @override
  Future<List<Quote>> getUserQuotes(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Quote(
        id: '1',
        userId: userId,
        brand: 'Renault',
        model: 'Clio',
        year: 2018,
        hasAccidents: false,
        amount: 500.0,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      Quote(
        id: '2',
        userId: userId,
        brand: 'Peugeot',
        model: '208',
        year: 2019,
        hasAccidents: true,
        amount: 800.0,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
    ];
  }

  @override
  Future<Quote> getQuoteById(String quoteId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Quote(
      id: quoteId,
      userId: 'ZaGt6Hxn1Uey3Uqx8tBXzSsVxI33',
      brand: 'Renault',
      model: 'Clio',
      year: 2018,
      hasAccidents: false,
      amount: 500.0,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    );
  }
}
