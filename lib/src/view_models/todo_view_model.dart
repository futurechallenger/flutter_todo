import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/models/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  late TodoItem? _todoItem;

  TodoItem? getTodoItem() => _todoItem;
  set todoItem(TodoItem todoItem) {
    _todoItem = todoItem;
    notifyListeners();
  }

  Future<void> updateTodo(int todoId, String content) async {
    try {
      await HttpRequest().updateTodo(todoId, content);
      _todoItem = TodoItem(
          id: todoId,
          content: content,
          status: _todoItem!.status,
          deleted: _todoItem!.deleted);
      notifyListeners();
    } catch (e) {
      _todoItem = null;
      notifyListeners();
    }
  }
}