import 'package:flutter_todo/src/common/http_request.dart';

class TodoRepository {
  final api = HttpRequest();

  TodoRepository();

  getAllTodoList({bool all = true, String completed = 'completed'}) async {
    return api.fetchTodoList(all: all, completed: completed);
  }

  delete(int id) async {
    return api.deleteTodo(id);
  }

  updateTodo(int todoId, String todoTitle) async {
    return api.updateTodo(todoId, todoTitle);
  }

  addTodo(String title) async {
    return api.addTodoItem(title);
  }
}
