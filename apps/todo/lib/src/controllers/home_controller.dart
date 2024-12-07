import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/models/todo_model.dart';
import 'package:todo/src/todo_repo.dart';

class SortType {
  String sortField = '';
  String order = '';

  SortType({required this.sortField, required this.order});
}

class HomeController extends GetxController {
  List<TodoItem> _todoList = [];
  RxList<Rx<SortType>> _sortings = <Rx<SortType>>[].obs;

  get todoList => _todoList;
  set todoList(value) {
    _todoList = value;
    update();
  }

  RxList<Rx<SortType>> get sortings => _sortings;
  set sortings(RxList<Rx<SortType>> sortList) {
    if (sortList.isEmpty) {
      _sortings = <Rx<SortType>>[].obs;
    }

    _sortings = sortList;
  }

  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void toggleSorting(SortType sortType) {
    final result =
        _sortings.where((e) => e.value.sortField == sortType.sortField);
    if (result.isEmpty) {
      _sortings.add(sortType.obs);
      return;
    }

    _sortings.removeWhere((e) => e.value.sortField == sortType.sortField);
  }

  void removeSortingField(String fieldName) {
    if (_sortings.where((p0) => p0.value.sortField == fieldName).isEmpty) {
      return;
    }

    _sortings.removeWhere((e) => e.value.sortField == fieldName);
  }

  bool hasSuchField(String field) {
    return sortings.where((e) => e.value.sortField == field).isNotEmpty;
  }

  Rx<SortType>? getSortObserver(String fieldName) {
    final sortType = sortings
        .firstWhereOrNull((element) => element.value.sortField == fieldName);
    return sortType;
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
