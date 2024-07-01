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
                child: Container(
                    height: 50.0,
                    color: Colors.lightBlueAccent,
                    child: Center(
                        child: Obx(
                            () => Text(AppLocalizations.of(context)!.todoStatus(
                                  _.rxTodoItem().content,
                                  '${_.rxTodoItem().status ?? 0}',
                                ))))),
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
              Obx(() => LongPressDraggable<TodoItem>(
                    data: _.rxTodoItem(),
                    feedback: Container(
                        color: Colors.white,
                        child: const SizedBox(
                            height: 90, child: Text("todo item"))),
                    child: const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Center(child: Text("Status"))),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: DragTarget<TodoItem>(
                            builder: (context, candidateItems, rejectedItems) {
                              return Container(
                                  color: Colors.green,
                                  child: const Text("Completed"));
                            },
                            onAcceptWithDetails: (details) {
                              debugPrint("Received details: $details");
                              _.updateTodoStatus(1);
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: DragTarget<TodoItem>(
                            builder: (context, candidateItems, rejectedItems) {
                              return const Text("In progress");
                            },
                            onAcceptWithDetails: (details) {
                              debugPrint("Received details: $details");
                              _.updateTodoStatus(0);
                            },
                          )),
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
}
