import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:todo/src/controllers/home_controller.dart';
import 'package:todo/src/pages/animations/implicit_animation_page.dart';
import 'package:todo/src/pages/animations/physics_animation_page.dart';
import 'package:todo/src/pages/responsive_page.dart';
import 'package:todo/src/pages/stream_page.dart';

import 'animations/tween_animation_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                title: const Text("Sort"),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => SafeArea(
                            child: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Sort by")),
                                  ),
                                  Obx(() => ListTile(
                                        title: const Text("Due Date"),
                                        trailing:
                                            controller.hasSuchField('due date')
                                                ? const Icon(
                                                    Icons.check,
                                                    color: Colors.blue,
                                                  )
                                                : null,
                                        selected:
                                            controller.hasSuchField('due date'),
                                        onTap: () {
                                          controller.toggleSorting(SortType(
                                              sortField: 'due date',
                                              order: 'desc'));
                                        },
                                      )),
                                  Obx(() => ListTile(
                                        title: const Text("Creation Date"),
                                        selected: controller
                                            .hasSuchField('creation date'),
                                        trailing: controller
                                                .hasSuchField('creation date')
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.blue,
                                              )
                                            : null,
                                        onTap: () {
                                          controller.toggleSorting(SortType(
                                              sortField: 'creation date',
                                              order: 'desc'));
                                        },
                                      ))
                                ],
                              ),
                            ),
                          ));
                },
              ),
              const Divider(),
              const ListTile(
                title: Text("Change Theme"),
              ),
              const Divider(),
              const ListTile(
                title: Text("Hide Completed Tasks"),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResponsivePage()));
                },
                title: const Text("Responsive Layout"),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StreamPage()));
                },
                title: const Text("Stream"),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  _showActionSheet(context);
                },
                title: const Text("Animation"),
              ),
            ],
          )),
    );
  }

  Widget getWidget() {
    const widgets = [Text("text 1"), Text("text 2")];
    return const Column(
      children: [...widgets],
    );
  }

  final value = 111;

  Widget getWidget2() {
    return Column(
      children: [
        if (value == 1) ...[const Text("text1"), const Text("text2")]
      ],
    );
  }

  void _showActionSheet(BuildContext context) {
    showAdaptiveActionSheet(context: context, actions: [
      BottomSheetAction(
          title: const Text("Tween Animation"),
          onPressed: (context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TweenAnimationPage()));
          }),
      BottomSheetAction(
          title: const Text("Physics Animation"),
          onPressed: (context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PhysicsAnimationPage()));
          }),
      BottomSheetAction(
          title: const Text("Implicit Animation"),
          onPressed: (context) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ImplicitAnimationPage()));
          }),
    ]);
  }
}
