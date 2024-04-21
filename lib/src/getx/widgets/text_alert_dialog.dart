import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/controllers/detail_controller.dart';
import 'package:flutter_todo/src/models/todo_model.dart';

Future<void> showTextAlertDialog(
    BuildContext context, DetailController controller,
    {bool isTitle = true}) {
  return showDialog(
      context: context,
      builder: (context) => PopScope(
          onPopInvoked: (didPop) {
            debugPrint("on pop invoked called");
            controller.titleEditingController.text = '';
            controller.noteEditingController.text = '';
          },
          child: TextAlertDialog(controller: controller)));
}

class TextAlertDialog extends StatelessWidget {
  const TextAlertDialog(
      {super.key, required this.controller, this.isTitle = true});
  final DetailController controller;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[const Text('Title:'), getTextField(isTitle)],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            if (isTitle) {
              // TODO: show error message like red border when it's empty
              if (controller.titleEditingController.text.isNotEmpty) {
                controller.rxTodoItem(TodoItem(
                    id: controller.rxTodoItem.value.id,
                    content: controller.titleEditingController.text,
                    note: controller.rxTodoItem().note));

                controller.titleEditingController.text = '';
              }
            } else {
              if (controller.noteEditingController.text.isNotEmpty) {
                controller.rxTodoItem(TodoItem(
                    id: controller.rxTodoItem.value.id,
                    content: controller.rxTodoItem().content,
                    note: controller.noteEditingController.text));

                controller.noteEditingController.text = '';
              }
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget getTextField(bool isTitle) {
    if (isTitle) {
      return TextField(
        controller: controller.titleEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: controller.todoItem?.content ?? '',
        ),
      );
    }

    return TextField(
      controller: controller.noteEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: controller.todoItem?.note ?? '',
      ),
    );
  }
}
