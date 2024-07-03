import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/controllers/detail_controller.dart';
import 'package:flutter_todo/src/getx/controllers/home_controller.dart';
import 'package:flutter_todo/src/getx/widgets/text_alert_dialog.dart';
import 'package:flutter_todo/src/models/todo_model.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.todoItem});

  final TodoItem todoItem;
  final controller = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          leading: PopScope(
            onPopInvoked: (didPop) {
              debugPrint('detail page pop');
            },
            child: BackButton(
              onPressed: () {
                Navigator.pop(context, "refresh");
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.titleEditingController.text.isNotEmpty) {
                    controller.updateTodoV2();
                  }
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        body: GetBuilder<DetailController>(
          initState: (_) => controller.fetchTodoById(todoItem.id!),
          builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50.0,
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () {
                        debugPrint("Todo content button is clicked");
                        showTextAlertDialog(
                          context,
                          _,
                        );
                      },
                      child: Obx(() => Text(_.rxTodoItem().content))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 50.0,
                  color: Colors.yellow,
                  child: TextButton(
                      onPressed: () {
                        showTextAlertDialog(context, _, isTitle: false);
                      },
                      child: Obx(
                          () => Text(_.rxTodoItem().note ?? 'No note added'))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 50.0,
                  color: Colors.lightBlueAccent,
                  child: TextButton(
                      onPressed: () {
                        // TODO: add event to calendar for android, ios and desktop(macOs).
                      },
                      child: const Text('Add to Calendar')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() => LongPressDraggable(
                      data: _.rxTodoItem(),
                      feedback: FractionalTranslation(
                        translation: const Offset(0.5, -0.5),
                        child: Container(
                          color: Colors.red,
                          height: 50.0,
                          child: const Text("Todo item"),
                        ),
                      ),
                      child: Container(
                        height: 50,
                        color: Colors.lightBlueAccent,
                        child: Stack(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!.todoStatus(
                                _.rxTodoItem().content,
                                '${_.rxTodoItem().status ?? 0}',
                              ))),
                            ),
                            if (_.actionStatus.value == 'updating')
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator()),
                                ),
                              )
                          ],
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    height: 50.0,
                    color: Colors.lightBlueAccent,
                    child: Center(
                        child:
                            Text(AppLocalizations.of(context)!.todoItems(10)))),
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
                child: SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDragTarget(_, "Completed", 1),
                      _buildDragTarget(_, "In Progress", 0),
                      IconButton(
                          onPressed: () async {
                            debugPrint("Delete icon button is clicked");
                            if (controller.todoItem?.id != null) {
                              await Get.find<HomeController>()
                                  .deleteTodo(todoId: controller.todoItem!.id!);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  DragTarget<TodoItem> _buildDragTarget(
      DetailController _, String title, int status) {
    return DragTarget<TodoItem>(
      builder: (context, candidateItems, rejectedItems) {
        final highlighted = candidateItems.isNotEmpty;
        return Transform.scale(
          scale: highlighted ? 1.2 : 1,
          child: Material(
            elevation: highlighted ? 8 : 4,
            color: highlighted ? const Color(0xFFF64209) : Colors.white,
            child: SizedBox(
                height: 80, width: 120, child: Center(child: Text(title))),
          ),
        );
      },
      onAcceptWithDetails: (details) {
        debugPrint("Received details: $details");
        _.updateTodoStatus(status);
      },
    );
  }
}
