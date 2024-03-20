import 'package:flutter_todo/src/common/http_request.dart';

class TodoRepository {
  final api = HttpRequest();

  TodoRepository();

  getAllTodoList() async {
    return api.fetchTodoList(completed: 'uncompleted');
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
