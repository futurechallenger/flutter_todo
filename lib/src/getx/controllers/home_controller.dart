import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late List<TodoItem> _todoList = [];

  get todoList => _todoList;
  set todoList(value) {
    _todoList = value;
    update();
  }

  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  Future<void> fetchTodoList(
      {bool all = true, String completed = 'completed'}) async {
    final todoList = await Get.find<TodoRepository>()
        .getAllTodoList(completed: 'uncompleted');

    this.todoList = todoList ?? [];
  }

  Future<void> addTodo({required String todo}) async {
    await Get.find<TodoRepository>().addTodo(todo);
    fetchTodoList();
  }

  @override
  void onInit() {
    fetchTodoList(all: true);

    focusNode.addListener(() {
      if (!focusNode.hasFocus && inputController.text.isNotEmpty) {
        addTodo(todo: inputController.text);
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    inputController.dispose();
    focusNode.dispose();

    super.onClose();
  }
}
