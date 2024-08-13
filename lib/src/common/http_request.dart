import 'dart:convert';

import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpRequest {
  final String hostUrl = dotenv.env['HOST_URL']!;
  var _client = http.Client();

  set client(c) => _client = c;
  get client => _client;

  Future<List<TodoItem>?> fetchTodoList({
    bool all = false,
    String completed = 'completed',
  }) async {
    final host = all == true ? "$hostUrl/todo" : "$hostUrl/todo/$completed";
    final response = await _client.get(Uri.parse(host));

    if (response.statusCode == 200) {
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
    } else {
      return null;
    }
  }

  Future<TodoItem?> fetchTodoById(int todoId) async {
    final response = await _client.get(Uri.parse('$hostUrl/todo/$todoId'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'OK') {
      } else {
        return null;
      }

      final data = body['data'] as Map<String, dynamic>;
      return TodoItem.fromJson(data);
    } else {
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

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'OK') {
        return;
      } else {
        throw Exception("Failed to add todo item");
      }
    } else {
      throw Exception("Failed to add todo item");
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await _client.delete(
      Uri.parse("$hostUrl/delete/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Failed to delete todo with id: {$id}");
    }
  }
}
