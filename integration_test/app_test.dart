import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/main.dart';
import 'package:integration_test/integration_test.dart';

// @GenerateMocks([http.Client])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('hello world test', (tester) async {
      await tester.pumpWidget(const GetxApplication());

      await tester.pumpAndSettle();
      final listTileFinder = find.text("hello");

      expect(listTileFinder, findsAtLeast(1));
    });
  });
}
