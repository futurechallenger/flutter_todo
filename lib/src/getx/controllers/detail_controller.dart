import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final actionStatus = "".obs; // "updating", "done" or ""

  var rxTodoItem = const TodoItem(content: '').obs;
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
    TodoItem todo = await Get.find<TodoRepository>().getTodo(todoId);

    titleEditingController.text = todo.content;
    noteEditingController.text = todo.note ?? '';

    rxTodoItem(todo);
  }

  Future<void> updateTodoV2() async {
    if (titleEditingController.text.isEmpty) {
      throw Exception("Todo title is empty");
    }

    await Get.find<TodoRepository>().updateTodo(todoItem!.id!,
        title: rxTodoItem.value.content, note: rxTodoItem.value.note);

    // update();
  }

  Future<void> updateTodoStatus(int status) async {
    actionStatus.value = "updating";

    await Future<void>.delayed(const Duration(seconds: 5));

    await Get.find<TodoRepository>().updateTodo(todoItem!.id!,
        title: rxTodoItem.value.content, status: rxTodoItem.value.status ?? 0);

    rxTodoItem(TodoItem(
        content: rxTodoItem.value.content,
        note: rxTodoItem.value.note,
        status: status,
        deleted: rxTodoItem.value.deleted,
        id: rxTodoItem.value.id));

    actionStatus.value = "done";
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
