import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late List<TodoItem> todoList = [];

  void fetchTodoList() async {
    final todoList =
        await Get.find<HttpRequest>().fetchTodoList(completed: 'uncompleted');
    this.todoList = todoList ?? [];

    update();
  }
}
