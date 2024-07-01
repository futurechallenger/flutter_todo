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

  Future<void> updateTodo(int todoId, String content, [String? note]) async {
    try {
      await HttpRequest().updateTodo(todoId, title: content);
      _todoItem = TodoItem(
          id: todoId,
          content: content,
          note: note ?? _todoItem!.note,
          status: _todoItem!.status,
          deleted: _todoItem!.deleted);
      notifyListeners();
    } catch (e) {
      _todoItem = null;
      notifyListeners();
    }
  }
}
