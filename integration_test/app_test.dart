import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/main.dart';
import 'package:integration_test/integration_test.dart';

// @GenerateMocks([http.Client])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('hello world test', (tester) async {
      // final client = MockClient();
      // final httpRequest = hs.HttpRequest();
      // httpRequest.client = client;

      // when(client.get(Uri.parse('http://localhost:17788/list/all'))).thenAnswer(
      //     (_) async => http.Response(
      //         '{"data": [{"id":1, "content": "hello","note": "&", "status": 0, "deleted": 0}], "message": "ok"}',
      //         200));

      await tester.pumpWidget(const GetxApplication());

      debugDumpApp();

      final listTileFinder = find.text("hello");

      expect(listTileFinder, findsOneWidget);
    });
  });
}
