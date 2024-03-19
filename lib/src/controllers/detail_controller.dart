import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  late TodoItem? _todoItem;
  set todoItem(value) {
    _todoItem = value;
    update();
  }

  get todoItem => _todoItem;
}
