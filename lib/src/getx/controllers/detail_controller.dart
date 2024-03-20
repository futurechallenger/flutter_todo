import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  late TodoItem? _todoItem;
  set todoItem(value) {
    _todoItem = value;
    update();
  }

  get todoItem => _todoItem;

  late int? _todoId;
  set todoId(value) => _todoId = value;
  get todoId => _todoId;

  late TextEditingController? titleEditingController;
  late TextEditingController? noteEditingController;

  void updateTodo(TodoItem todoItem) async {
    await Get.find<HttpRequest>().updateTodo(todoItem.id, todoItem.content);
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
