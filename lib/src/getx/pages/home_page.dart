import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/controllers/home_controller.dart';
import 'package:flutter_todo/src/getx/pages/detail_page.dart';
import 'package:flutter_todo/src/getx/pages/list_row.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
        ),
        body: GetBuilder<HomeController>(
          init: Get.find<HomeController>(),
          builder: (controller) => Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  restorationId: 'sampleItemListView',
                  itemCount: controller.todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.todoList[index];

                    return ListRow(
                        content: item.content,
                        navigateTo: () async {
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (builder) => const DetailPage(),
                                  settings: RouteSettings(arguments: item)));
                          debugPrint("result from prev page is $result");
                          if (result == 'refresh') {
                            controller.fetchTodoList();
                          }
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 80,
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      debugPrint("Textfield input with go $value");
                      if (value.isNotEmpty) {
                        controller.addTodo(todo: value);
                        controller.inputController.text = '';
                      }
                    },
                    controller: controller.inputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '',
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
