import 'package:flutter/material.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:flutter_todo/src/screens/sample_item_list_view.dart';

import 'add_todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoItem> items = [];

  void addItem(TodoItem item) {
    setState(() {
      items.add(item);
    });
  }

  void deleteItem(TodoItem item) {
    setState(() {
      items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("action settings icon is clicked");
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  color: Colors.red, child: const SampleItemListView())),
          AddTodoTile(addTodoCallback: addItem)
        ],
      ),
    );
  }
}
