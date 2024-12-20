import 'package:todo/src/common/http_request.dart';

class TodoRepository {
  final api = HttpRequest();

  TodoRepository();

  getAllTodoList({bool all = true, String completed = 'completed'}) async {
    return api.fetchTodoList(all: all, completed: completed);
  }

  getTodo(int todoId) async {
    return api.fetchTodoById(todoId);
  }

  delete(int id) async {
    return api.deleteTodo(id);
  }

  updateTodo(int todoId, String todoTitle,
      [String? note, int? status, int? deleted]) async {
    return api.updateTodo(todoId, todoTitle,
        note: note, status: status, deleted: deleted);
  }

  addTodo(String title) async {
    return api.addTodoItem(title);
  }
}
