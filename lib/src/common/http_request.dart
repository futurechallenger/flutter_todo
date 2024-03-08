import 'dart:convert';

import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  final String hostUrl = 'http://localhost:17788';

  Future<List<TodoItem>?> fetchTodoList(String completed) async {
    final response = await http.get(Uri.parse("$hostUrl/list/$completed"));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'ok') {
      } else {
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

  Future<TodoItem> addTodoItem(String todoTitle) async {
    final response = await http.post(Uri.parse("$hostUrl/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({'content': todoTitle}));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'ok') {
        return TodoItem.fromJson(body['data']);
      } else {
        throw Exception("Failed to add todo item");
      }
    } else {
      throw Exception("Failed to add todo item");
    }
  }

  Future<TodoItem> updateTodo(int id, String todoTitle,
      {int? status, int? deleted}) async {
    final response = await http.post(Uri.parse("$hostUrl/update"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({
          'todo': {
            'id': id,
            'content': todoTitle,
            'status': status,
            'deleted': deleted
          }
        }));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] == 'ok') {
        return TodoItem.fromJson(body['data']);
      } else {
        throw Exception("Failed to add todo item");
      }
    } else {
      throw Exception("Failed to add todo item");
    }
  }
}
