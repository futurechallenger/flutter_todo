import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo/src/getx/controllers/home_controller.dart';
import 'package:flutter_todo/src/getx/pages/detail_page.dart';
import 'package:flutter_todo/src/getx/pages/list_row.dart';
import 'package:flutter_todo/src/getx/pages/settings_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (builder) => const SettingsPage()));
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: GetBuilder<HomeController>(
          init: Get.find<HomeController>(),
          builder: (controller) => Column(
            children: [
              // SizedBox(height: 100, width: 500, child: getSortControl()),
              getSortControl(),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  restorationId: 'sampleItemListView',
                  itemCount: controller.todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.todoList[index];

                    return ListRow(
                        content: item.content,
                        navigateTo: () async {
                          final result = await Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (builder) => DetailPage(
                              todoItem: item,
                            ),
                          ));
                          debugPrint("result from prev page is $result");
                          if (result == 'refresh') {
                            controller.fetchTodoList();
                          }
                        });
                  },
                  separatorBuilder: (context, index) => const Divider(),
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

  Widget getSortControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {},
                child: const Wrap(children: [
                  Text("Due Date"),
                  Icon(
                    Icons.arrow_drop_down,
                  )
                ])),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {},
                child: const Wrap(
                    children: [Text("Due Date"), Icon(Icons.arrow_drop_down)])),
            IconButton(onPressed: () {}, icon: const Icon(Icons.close))
          ],
        )
      ],
    );
  }
}
