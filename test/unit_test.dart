// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'dart:io';

import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unit_test.mocks.dart';
import 'package:flutter_todo/src/common/http_request.dart' as hs;

@GenerateMocks([http.Client])
void main() {
  group('Plus Operator', () {
    test('should add two numbers together', () {
      expect(1 + 1, 2);
    });
  });

  group('Http request', () {
    test('should list ', () async {
      final client = MockClient();
      final httpRequest = hs.HttpRequest();
      httpRequest.client = client;

      when(client.get(Uri.parse('http://localhost:17788/list/all'))).thenAnswer(
          (_) async => http.Response(
              '{"data": [{"id":1, "content": "hello","note": "&", "status": 0, "deleted": 0}], "message": "ok"}',
              200));

      expect(await httpRequest.fetchTodoList(all: true), isA<List<TodoItem>>());
    });
  });
}
