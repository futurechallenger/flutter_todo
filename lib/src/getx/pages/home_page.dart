import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/controllers/home_controller.dart';
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
          builder: (controller) => ListView.builder(
            restorationId: 'sampleItemListView',
            itemCount: controller.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = controller.todoList[index];

              return ListTile(
                  title: Text(item.content),
                  leading: const Icon(Icons.circle_outlined),
                  onTap: () {
                    // Navigator.restorablePushNamed(
                    //     context, ItemDetailsView.routeName,
                    //     arguments: item.toMap());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ItemDetailsView(todoItem: item)));
                    Get.toNamed('/detail?id=${item.id}');
                  });
            },
          ),
        )

        // Row(
        //   children: [
        //     const Text("Home page"),
        //     ElevatedButton(
        //         onPressed: () {
        //           Get.toNamed("/detail");
        //         },
        //         child: const Text("Detail")),
        //     ElevatedButton(
        //         onPressed: () {
        //           Get.toNamed("/settings");
        //         },
        //         child: const Text("Settings")),
        //   ],
        // ),
        );
  }
}
