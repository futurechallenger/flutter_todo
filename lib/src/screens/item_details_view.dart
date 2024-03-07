import 'package:flutter/material.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:flutter_todo/src/screens/widgets/text_input_switch_view.dart';

class ItemDetailsView extends StatefulWidget {
  const ItemDetailsView({super.key, required this.todoItem});

  static const routeName = '/sample_item';
  final TodoItem todoItem;

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void updateItem(String content) async {
    debugPrint("update item");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: TextInputSwitchView(
                addTodoCallback: updateItem,
              ),
              // child: Text(todoItem.content),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
