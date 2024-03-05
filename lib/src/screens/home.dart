import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/http_request.dart';
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

  void addItem(String content) async {
    try {
      final updatedItem = await HttpRequest().addTodoItem(content);
      setState(() {
        items.add(updatedItem);
      });
    } catch (e) {
      debugPrint("Error in adding todo item");
    }
  }

  void deleteItem(TodoItem item) async {
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
