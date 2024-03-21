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

  // Focus node
  final titleFocusNode = FocusNode();
  final noteFocusNode = FocusNode();

  fetchTodoById(int todoId) async {
    final todo = await Get.find<TodoRepository>().getTodo(todoId);
    todoItem = todo;

    titleEditingController.text = todoItem?.content ?? '';
    noteEditingController.text = todoItem?.note ?? '';
  }

  void updateTodo(TodoItem todoItem) async {
    await Get.find<TodoRepository>()
        .updateTodo(todoItem.id, todoItem.content, todoItem.note);
    update();
  }

  @override
  void onInit() async {
    // final todoId = int.parse(Get.parameters['id'] ?? '');
    // await fetchTodoById(todoId);

    // titleEditingController.addListener(() {});
    // noteEditingController.addListener(() {});

    titleFocusNode.addListener(() {
      if (!titleFocusNode.hasFocus &&
          titleEditingController.text.isNotEmpty &&
          todoItem != null) {
        todoItem = TodoItem(
            id: todoItem!.id,
            content: titleEditingController.text,
            note: todoItem!.note,
            status: todoItem!.status,
            deleted: todoItem!.deleted);
        updateTodo(todoItem!);
      }
    });
    noteFocusNode.addListener(() {
      if (!noteFocusNode.hasFocus &&
          noteEditingController.text.isNotEmpty &&
          todoItem != null) {
        todoItem = TodoItem(
            id: todoItem!.id,
            content: todoItem!.content,
            note: noteEditingController.text,
            status: todoItem!.status,
            deleted: todoItem!.deleted);
        updateTodo(todoItem!);
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    titleEditingController.dispose();
    noteEditingController.dispose();
    titleFocusNode.dispose();
    noteFocusNode.dispose();

    super.onClose();
  }
}
