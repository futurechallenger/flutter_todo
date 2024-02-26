import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/screens/sample_item_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = "/home";

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
          Container(
            color: Colors.black54,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: 80,
                      child: TextButton(
                          onPressed: () {
                            debugPrint("+ Add button is clicked");
                          },
                          child: const Text("+ Add",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20)))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
