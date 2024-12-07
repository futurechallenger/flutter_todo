import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo/src/models/todo_model.dart';
import 'package:todo/src/todo_repo.dart';

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
    final TodoItem todo = await Get.find<TodoRepository>().getTodo(todoId);

    titleEditingController.text = todo.content;
    noteEditingController.text = todo.note ?? '';

    rxTodoItem(todo);
  }

  Future<void> updateTodoV2() async {
    if (titleEditingController.text.isEmpty) {
      throw Exception("Todo title is empty");
    }

    await Get.find<TodoRepository>().updateTodo(
        todoItem!.id!, rxTodoItem.value.content, rxTodoItem.value.note);

    // update();
  }

  void resetTextController() {
    titleEditingController.text = rxTodoItem.value.content;
    noteEditingController.text = rxTodoItem.value.note ?? '';
  }

  @override
  void onClose() {
    debugPrint("detail controller closed");

    titleEditingController.dispose();
    noteEditingController.dispose();

    super.onClose();
  }
}
