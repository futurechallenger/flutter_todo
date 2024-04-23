import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/controllers/home_controller.dart';
import 'package:flutter_todo/src/getx/pages/detail_page.dart';
import 'package:flutter_todo/src/getx/pages/list_row.dart';
import 'package:flutter_todo/src/getx/pages/settings_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => const Text("Todo")),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (homeController.sortings.isNotEmpty) {
              return getSortControl();
            }
            return const SizedBox(
              width: 1,
              height: 1,
            );
          }),
          Expanded(
            flex: 1,
            child: GetBuilder<HomeController>(
                init: Get.find<HomeController>(),
                builder: (controller) => ListView.separated(
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
                    )),
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
                    homeController.addTodo(todo: value);
                    homeController.inputController.text = '';
                  }
                },
                controller: homeController.inputController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSortControl() {
    return GetX<HomeController>(
      init: Get.find<HomeController>(),
      initState: (_) {},
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_.hasSuchField('due date')) ...[
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
                      onPressed: () {
                        _.toggleSorting(
                            SortType(sortField: "due date", order: ''));
                      },
                      icon: const Icon(
                        Icons.close,
                      ))
                ],
              )
            ],
            if (_.hasSuchField('creation date')) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Wrap(children: [
                        Text("Creation Date"),
                        Icon(Icons.arrow_drop_down)
                      ])),
                  IconButton(
                      onPressed: () {
                        _.toggleSorting(
                            SortType(sortField: "creation date", order: ''));
                      },
                      icon: const Icon(Icons.close))
                ],
              )
            ]
          ],
        );
      },
    );
  }
}
