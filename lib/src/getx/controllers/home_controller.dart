import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late List<TodoItem> _todoList = [];

  get todoList => _todoList;
  set todoList(value) {
    _todoList = value;
    update();
  }

  void fetchTodoList({bool all = true, String completed = 'completed'}) async {
    final todoList = await Get.find<TodoRepository>()
        .getAllTodoList(completed: 'uncompleted');

    this.todoList = todoList ?? [];
  }

  @override
  void onInit() {
    fetchTodoList(all: true);
    super.onInit();
  }
}
