import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';

class SortType {
  String sortField = '';
  String order = '';

  SortType({required this.sortField, required this.order});
}

class HomeController extends GetxController {
  late List<TodoItem> _todoList = [];
  final _sortings = <SortType>[].obs;

  get todoList => _todoList;
  set todoList(value) {
    _todoList = value;
    update();
  }

  get sortings => _sortings;
  set sortings(value) {
    _sortings.add(value);
  }

  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void toggleSorting(SortType sortType) {
    final result = _sortings.where((e) => e.sortField == sortType.sortField);
    if (result.isEmpty) {
      _sortings.add(sortType);
      return;
    }

    _sortings.removeWhere((e) => e.sortField == sortType.sortField);
  }

  bool hasSuchField(String field) {
    return sortings.where((e) => e.sortField == field).length > 0;
  }

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

  Future<void> deleteTodo({required int todoId}) async {
    await Get.find<TodoRepository>().delete(todoId);
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
