import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_flutter_app/domain/repositories/claim_repository.dart';
import 'package:my_flutter_app/presentation/providers/claim_provider.dart';
import 'package:my_flutter_app/presentation/screens/claim/claim_screen.dart';
import 'package:my_flutter_app/domain/entities/claim.dart';

class MockClaimRepository extends Mock implements ClaimRepository {}

void main() {
  late MockClaimRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockClaimRepository();
    container = ProviderContainer(
      overrides: [
        claimRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  testWidgets('Claim screen shows form fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ClaimScreen(),
        ),
      ),
    );

    // Verify form fields are present
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Localisation'), findsOneWidget);
    expect(find.text('Photos'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Submit button is disabled when form is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ClaimScreen(),
        ),
      ),
    );

    final submitButton = find.byType(ElevatedButton);
    expect(tester.widget<ElevatedButton>(submitButton).enabled, isFalse);
  });

  testWidgets('Submit button is enabled when description is filled',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ClaimScreen(),
        ),
      ),
    );

    // Enter description
    await tester.enterText(find.byType(TextFormField).first, 'Test claim');
    await tester.pump();

    final submitButton = find.byType(ElevatedButton);
    expect(tester.widget<ElevatedButton>(submitButton).enabled, isTrue);
  });

  testWidgets('Shows error message when submitting without location',
      (WidgetTester tester) async {
    when(mockRepository.createClaim(any)).thenAnswer((_) async => Claim(
          id: 'test_id',
          userId: 'test_user',
          description: 'Test claim',
          status: ClaimStatus.pending,
          createdAt: DateTime.now(),
          latitude: 0.0,
          longitude: 0.0,
          photoUrls: [],
        ));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ClaimScreen(),
        ),
      ),
    );

    // Enter description
    await tester.enterText(find.byType(TextFormField).first, 'Test claim');
    await tester.pump();

    // Tap submit button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify error message
    expect(find.text('Veuillez activer la localisation'), findsOneWidget);
  });

  testWidgets('Shows loading indicator when submitting',
      (WidgetTester tester) async {
    when(mockRepository.createClaim(any)).thenAnswer((_) async => Claim(
          id: 'test_id',
          userId: 'test_user',
          description: 'Test claim',
          status: ClaimStatus.pending,
          createdAt: DateTime.now(),
          latitude: 0.0,
          longitude: 0.0,
          photoUrls: [],
        ));

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ClaimScreen(),
        ),
      ),
    );

    // Enter description
    await tester.enterText(find.byType(TextFormField).first, 'Test claim');
    await tester.pump();

    // Mock location
    // TODO: Add location mocking

    // Tap submit button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
} 