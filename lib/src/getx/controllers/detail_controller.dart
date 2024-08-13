import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final actionStatus = "".obs; // "updating", "done" or ""

  var rxTodoItem = const TodoItem(title: '').obs;
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

    titleEditingController.text = todo.title;
    noteEditingController.text = todo.desc ?? '';

    rxTodoItem(todo);
  }

  Future<void> updateTodoV2() async {
    if (titleEditingController.text.isEmpty) {
      throw Exception("Todo title is empty");
    }

    await Get.find<TodoRepository>().updateTodo(todoItem!.id!,
        title: rxTodoItem.value.title, note: rxTodoItem.value.desc);

    // update();
  }

  Future<void> updateTodoStatus(int status) async {
    actionStatus.value = "updating";

    await Future<void>.delayed(const Duration(seconds: 5));

    await Get.find<TodoRepository>().updateTodo(todoItem!.id!,
        title: rxTodoItem.value.title, status: rxTodoItem.value.status ?? 0);

    rxTodoItem(TodoItem(
        title: rxTodoItem.value.title,
        desc: rxTodoItem.value.desc,
        status: status,
        deleted: rxTodoItem.value.deleted,
        id: rxTodoItem.value.id));

    actionStatus.value = "done";
  }

  void resetTextController() {
    titleEditingController.text = rxTodoItem.value.title;
    noteEditingController.text = rxTodoItem.value.desc ?? '';
  }

  @override
  void onClose() {
    debugPrint("detail controller closed");

    titleEditingController.dispose();
    noteEditingController.dispose();

    super.onClose();
  }
}
