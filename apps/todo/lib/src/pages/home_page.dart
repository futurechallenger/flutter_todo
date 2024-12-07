import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/src/controllers/home_controller.dart';
import 'package:todo/src/pages/animations/hero_animation_page.dart';
import 'package:todo/src/pages/detail_page.dart';
import 'package:todo/src/pages/settings_page.dart';
import 'package:todo/src/widgets/list_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

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
                        return Hero(
                          tag: item.content,
                          child: Material(
                            type: MaterialType.transparency,
                            child: ListRow(
                                content: item.content,
                                navigateTo: () async {
                                  final result = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (builder) {
                                      if (index == 0) {
                                        return HeroAnimationPage(
                                          todoItem: item,
                                        );
                                      }
                                      return DetailPage(
                                        todoItem: item,
                                      );
                                    },
                                  ));
                                  debugPrint(
                                      "result from prev page is $result");
                                  if (result == 'refresh') {
                                    controller.fetchTodoList();
                                  }
                                }),
                          ),
                        );
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
                      onPressed: () {
                        debugPrint('creation date clicked');
                        final sortType = _.getSortObserver('due date');
                        if (sortType == null) return;

                        sortType(SortType(
                            sortField: sortType.value.sortField,
                            order: sortType.value.order == 'desc'
                                ? 'asc'
                                : 'desc'));
                      },
                      child: Wrap(children: [
                        const Text("Due Date"),
                        getIconByOrder(_, 'due date')
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
                      onPressed: () {
                        debugPrint('creation date clicked');
                        final sortType = _.getSortObserver('creation date');
                        if (sortType == null) return;

                        sortType(SortType(
                            sortField: sortType.value.sortField,
                            order: sortType.value.order == 'desc'
                                ? 'asc'
                                : 'desc'));
                      },
                      child: Wrap(children: [
                        const Text("Creation Date"),
                        // No need obx here?
                        // Inside `GetX`, an obx is ok, but in `GetBuilder` it's no ok
                        Obx(() =>
                            _.getSortObserver('creation date')?.value.order ==
                                    'desc'
                                ? const Icon(Icons.arrow_drop_down)
                                : const Icon(Icons.arrow_drop_up))
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

  Widget getIconByOrder(HomeController controller, String fieldName) {
    final creationDateSort = controller.getSortObserver(fieldName);
    if (creationDateSort == null || creationDateSort.value.order == 'desc') {
      return const Icon(Icons.arrow_drop_down);
    } else {
      return const Icon(Icons.arrow_drop_up);
    }
  }
}
