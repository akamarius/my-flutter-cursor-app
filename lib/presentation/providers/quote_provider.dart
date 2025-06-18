import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/domain/repositories/quote_repository.dart';

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  throw UnimplementedError('QuoteRepository not initialized');
});

final quoteStateProvider = StateNotifierProvider<QuoteNotifier, AsyncValue<List<Quote>>>((ref) {
  final repository = ref.watch(quoteRepositoryProvider);
  return QuoteNotifier(repository);
});

final quoteRequestProvider = StateNotifierProvider<QuoteRequestNotifier, AsyncValue<Quote?>>((ref) {
  final repository = ref.watch(quoteRepositoryProvider);
  return QuoteRequestNotifier(repository);
});

class QuoteNotifier extends StateNotifier<AsyncValue<List<Quote>>> {
  final QuoteRepository _repository;

  QuoteNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadUserQuotes(String userId) async {
    state = const AsyncValue.loading();
    try {
      final quotes = await _repository.getUserQuotes(userId);
      state = AsyncValue.data(quotes);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class QuoteRequestNotifier extends StateNotifier<AsyncValue<Quote?>> {
  final QuoteRepository _repository;

  QuoteRequestNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> requestQuote(QuoteRequest request) async {
    state = const AsyncValue.loading();
    try {
      final quote = await _repository.requestQuote(request);
      state = AsyncValue.data(quote);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
} 