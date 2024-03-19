import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  late List<TodoItem> todoList = [];

  void fetchTodoList() async {
    final todoList = await HttpRequest().fetchTodoList('uncompleted');
    this.todoList = todoList ?? [];

    update();
  }
}
