import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final rxTodoItem = const TodoItem(content: '').obs;
  set todoItem(value) {
    rxTodoItem(value);
  }

  TodoItem? get todoItem {
    return rxTodoItem.value;
  }

  static DetailController get to => Get.find();

  // Text editing controller
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();

  Future<void> fetchTodoById(int todoId) async {
    final todo = await Get.find<TodoRepository>().getTodo(todoId);
    rxTodoItem(todo);

    // titleEditingController.text = todoItem?.content ?? '';
    // noteEditingController.text = todoItem?.note ?? '';
  }

  Future<void> updateTodoV2() async {
    if (titleEditingController.text.isEmpty) {
      throw Exception("Todo title is empty");
    }

    await Get.find<TodoRepository>().updateTodo(
        todoItem!.id!, rxTodoItem.value.content, rxTodoItem.value.note);

    // update();
  }

  @override
  void onClose() {
    titleEditingController.dispose();
    noteEditingController.dispose();

    super.onClose();
  }
}
