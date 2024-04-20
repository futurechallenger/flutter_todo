import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  TodoItem? _todoItem;
  set todoItem(value) {
    _todoItem = value;
    update();
  }

  TodoItem? get todoItem {
    return _todoItem;
  }

  // Text editing controller
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();

  fetchTodoById(int todoId) async {
    final todo = await Get.find<TodoRepository>().getTodo(todoId);
    todoItem = todo;

    titleEditingController.text = todoItem?.content ?? '';
    noteEditingController.text = todoItem?.note ?? '';
  }

  Future<void> updateTodoV2() async {
    if (titleEditingController.text.isEmpty) {
      throw Exception("Todo title is empty");
    }

    await Get.find<TodoRepository>().updateTodo(
        todoItem!.id!, titleEditingController.text, noteEditingController.text);

    update();
  }

  @override
  void onClose() {
    titleEditingController.dispose();
    noteEditingController.dispose();

    super.onClose();
  }
}
