import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/http_request.dart';
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
    await HttpRequest().updateTodo(widget.todoItem.id, content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("App bar delete clicked");
                HttpRequest().deleteTodo(widget.todoItem.id);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: Colors.green,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  color: Colors.blue,
                  child: const Text("Left"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: TextInputSwitchView(
                    content: widget.todoItem.content,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    inputDecoration: InputDecoration(
                        hintText: widget.todoItem.content,
                        hintStyle: const TextStyle(color: Colors.black),
                        border: InputBorder.none),
                    addTodoCallback: updateItem,
                  ),
                  // child: Text(todoItem.content),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  color: Colors.yellow,
                  child: const Text("Right"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
