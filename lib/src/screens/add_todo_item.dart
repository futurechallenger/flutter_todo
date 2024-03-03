import 'package:flutter/material.dart';

class TodoItemView extends StatefulWidget {
  const TodoItemView({super.key});

  @override
  State<TodoItemView> createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {
  @override
  Widget build(BuildContext context) {
    return const Text("hello, world!");
  }
}
