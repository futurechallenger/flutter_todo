import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  late TodoItem? _todoItem;
  set todoItem(value) {
    _todoItem = value;
    update();
  }

  TodoItem? get todoItem {
    return _todoItem;
  }

  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();

  fetchTodoById(int todoId) async {
    final todo = await Get.find<TodoRepository>().getTodo(todoId);
    todoItem = todo;

    titleEditingController.text = todoItem?.content ?? '';
    noteEditingController.text = todoItem?.note ?? '';
  }

  void updateTodo(TodoItem todoItem) async {
    await Get.find<HttpRequest>().updateTodo(todoItem.id, todoItem.content);
    update();
  }

  @override
  void onInit() async {
    final todoId = int.parse(Get.parameters['id'] ?? '');
    await fetchTodoById(todoId);

    super.onInit();
  }
}
