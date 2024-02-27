import 'package:flutter/material.dart';
import 'package:flutter_todo/src/screens/sample_item.dart';
import 'package:flutter_todo/src/screens/sample_item_list_view.dart';

import 'add_todo_tile.dart';

int SAMPLE_ITEM_ID_COUNTER = 1;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SampleItem> items = [];

  void addItem(SampleItem item) {
    setState(() {
      items.add(item);
    });
  }

  void deleteItem(SampleItem item) {
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
                  color: Colors.red, child: SampleItemListView(items: items))),
          AddTodoTile(addTodoCallback: addItem)
        ],
      ),
    );
  }
}
