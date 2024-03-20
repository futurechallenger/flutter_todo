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

  void updateTodo(TodoItem todoItem) async {
    await Get.find<HttpRequest>().updateTodo(todoItem.id, todoItem.content);
    update();
  }
}
