import 'package:flutter/material.dart';
import 'package:flutter_todo/src/common/http_request.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:flutter_todo/src/screens/widgets/text_input_switch_view.dart';
import 'package:flutter_todo/src/view_models/todo_view_model.dart';
import 'package:provider/provider.dart';

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
    Provider.of<TodoViewModel>(context, listen: false).todoItem =
        widget.todoItem;
  }

  void updateItem(String content) async {
    await HttpRequest().updateTodo(widget.todoItem.id!, content);
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
              child: Consumer<TodoViewModel>(
                builder: (context, model, child) {
                  final todoTitle = model.getTodoItem()?.content ?? "";
                  return TextInputSwitchView(
                    content: todoTitle,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    inputDecoration: InputDecoration(
                        hintText: todoTitle,
                        hintStyle: const TextStyle(color: Colors.black),
                        border: InputBorder.none),
                    // addTodoCallback: updateItem,
                    addTodoCallback: (String todoContent) {
                      context
                          .read<TodoViewModel>()
                          .updateTodo(widget.todoItem.id!, todoContent);
                    },
                  );
                },
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
