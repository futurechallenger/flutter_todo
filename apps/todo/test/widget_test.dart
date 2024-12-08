import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/src/widgets/list_row.dart';

void main() {
  group('MyWidget', () {
    testWidgets('should display a string of text', (WidgetTester tester) async {
      // Define a Widget
      const myWidget = MaterialApp(
        home: Scaffold(
          body: Text('Hello'),
        ),
      );

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(myWidget);

      // Verify myWidget shows some text
      expect(find.byType(Text), findsOneWidget);
    });
  });

  group('test list widget', () {
    testWidgets('list all todo items', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ListRow(
              content: "hello world",
              navigateTo: () {
                debugPrint("navigate to is called");
              }),
        ),
      ));

      debugDumpApp();

      final titleFinder = find.text('hello world');
      expect(titleFinder, findsOneWidget);
    });
  });
}
