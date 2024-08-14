import 'dart:convert';

import 'package:flutter_todo/src/common/logger_provider.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpRequest {
  final logger = getLogger();

  final String hostUrl = dotenv.env['HOST_URL']!;
  var _client = http.Client();

  set client(c) => _client = c;
  get client => _client;

  Future<List<TodoItem>?> fetchTodoList({
    bool all = false,
    String completed = 'completed',
  }) async {
    try {
      final host = all == true ? "$hostUrl/todo" : "$hostUrl/todo/$completed";

      logger.i("get todo list with host: $host");

      final response = await _client.get(Uri.parse(host));

      if (response.statusCode < 200 || response.statusCode > 300) {
        return null;
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] != 'OK') {
        return null;
      }

      final data = body['data'] as List<dynamic>;
      final List<TodoItem> todoItemList = [];
      for (var e in data) {
        todoItemList.add(TodoItem.fromJson(e));
      }

      return todoItemList;
    } catch (e) {
      logger.e("Error fetching todo list", error: e);
      return null;
    }
  }

  Future<TodoItem?> fetchTodoById(int todoId) async {
    try {
      logger.i("fetching todo with id $todoId");

      final response = await _client.get(Uri.parse('$hostUrl/todo/$todoId'));

      if (response.statusCode < 200 || response.statusCode > 300) {
        return null;
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'OK') {
      } else {
        return null;
      }

      final data = body['data'] as Map<String, dynamic>;

      return TodoItem.fromJson(data);
    } catch (e) {
      logger.e("Error fetching a todo item", error: e);
      return null;
    }
  }

  Future<TodoItem> addTodoItem(String todoTitle) async {
    final response = await _client.post(Uri.parse("$hostUrl/todo/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({'title': todoTitle}));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'OK') {
        return TodoItem.fromJson(body['data']);
      } else {
        throw Exception("Failed to add todo item");
      }
    } else {
      throw Exception("Failed to add todo item");
    }
  }

  Future<void> updateTodo(int id,
      {String? title, String? note, int? status, int? deleted}) async {
    try {
      logger.i(
          "Updating todo $id, with title: $title, note: $note, deleted: $deleted");

      final response = await _client.post(Uri.parse("$hostUrl/update"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: json.encode({
            'todo': {
              'id': id,
              'content': title,
              'note': note,
              'status': status,
              'deleted': deleted
            }
          }));

      if (!isHttpStatusOK(response.statusCode)) {
        return;
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'OK') {
        return;
      } else {
        throw Exception("Failed to add todo item");
      }
    } catch (e) {
      logger.e('update todo item error', error: e);
      rethrow;
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final response = await _client.delete(
        Uri.parse("$hostUrl/delete/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (isHttpStatusOK(response.statusCode)) return;

      throw Exception("Failed to delete todo with id: {$id}");
    } catch (e) {
      logger.e("Error deleting a todo item", error: e);
      rethrow;
    }
  }

  bool isHttpStatusOK(int statusCode) {
    return statusCode >= 200 || statusCode < 300;
  }
}
