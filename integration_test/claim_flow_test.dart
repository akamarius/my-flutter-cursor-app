import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_flutter_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Claim Declaration Flow', () {
    testWidgets('Complete claim declaration flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to claims screen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify we're on the claim screen
      expect(find.text('Déclarer un sinistre'), findsOneWidget);

      // Fill in the form
      await tester.enterText(
        find.byType(TextFormField).first,
        'Test claim description',
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextFormField).last,
        'Test claim notes',
      );
      await tester.pumpAndSettle();

      // Mock location permission
      // TODO: Add location permission mocking

      // Add photos
      await tester.tap(find.byIcon(Icons.add_a_photo));
      await tester.pumpAndSettle();

      // Mock photo selection
      // TODO: Add photo selection mocking

      // Submit the claim
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify success message
      expect(find.text('Sinistre déclaré avec succès'), findsOneWidget);

      // Verify navigation back to claims list
      await tester.pumpAndSettle();
      expect(find.text('Mes sinistres'), findsOneWidget);

      // Verify new claim appears in the list
      expect(find.text('Test claim description'), findsOneWidget);
    });

    testWidgets('Error handling in claim declaration',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to claims screen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Try to submit without filling the form
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify error message
      expect(find.text('Veuillez remplir tous les champs requis'), findsOneWidget);

      // Fill only description
      await tester.enterText(
        find.byType(TextFormField).first,
        'Test claim description',
      );
      await tester.pumpAndSettle();

      // Try to submit without location
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify location error message
      expect(find.text('Veuillez activer la localisation'), findsOneWidget);
    });

    testWidgets('Photo limit handling', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to claims screen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Try to add more than 5 photos
      for (var i = 0; i < 6; i++) {
        await tester.tap(find.byIcon(Icons.add_a_photo));
        await tester.pumpAndSettle();
      }

      // Verify photo limit message
      expect(find.text('Maximum 5 photos autorisées'), findsOneWidget);
    });
  });
} 