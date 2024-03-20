import 'package:flutter/material.dart';
import 'package:flutter_todo/src/getx/controllers/detail_controller.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
          init: Get.find<DetailController>(),
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller.titleEditingController,
                    focusNode: controller.titleFocusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: controller.todoItem?.content ?? '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    color: Colors.yellow,
                    child: SizedBox(
                      height: 190,
                      width: double.infinity,
                      child: TextField(
                        controller: controller.noteEditingController,
                        focusNode: controller.noteFocusNode,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: controller.todoItem?.note ?? '',
                        ),
                        minLines: 5,
                        maxLines: 5,
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
