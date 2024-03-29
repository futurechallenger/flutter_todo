// This is an example Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
//
// Visit https://flutter.dev/docs/cookbook/testing/widget/introduction for
// more information about Widget testing.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/src/getx/pages/list_row.dart';

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
