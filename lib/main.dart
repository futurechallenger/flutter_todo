import 'package:flutter/material.dart';
import 'package:flutter_todo/src/app.dart';
import 'package:flutter_todo/src/getx/controllers/detail_controller.dart';
import 'package:flutter_todo/src/getx/controllers/home_controller.dart';
import 'package:flutter_todo/src/getx/pages/detail_page.dart';
import 'package:flutter_todo/src/getx/pages/home_page.dart';
import 'package:flutter_todo/src/getx/pages/settings_page.dart';
import 'package:flutter_todo/src/getx/todo_repo.dart';
import 'package:flutter_todo/src/view_models/todo_view_model.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  // runApp(MultiProvider(
  //     providers: [ChangeNotifierProvider(create: (context) => TodoViewModel())],
  //     child: MyApp(settingsController: settingsController)));
  runApp(const GetxApplication());
}

class GetxApplication extends StatelessWidget {
  const GetxApplication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetxBindings(),
      home: const HomePage(),
    );
    // initialRoute: '/',
    // getPages: [
    //   GetPage(name: '/', page: () => const HomePage()),
    //   GetPage(name: '/detail', page: () => const DetailPage()),
    //   GetPage(name: '/settings', page: () => const SettingsPage())
    // ],
  }
}

class GetxBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<TodoRepository>(TodoRepository(), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
  }
}
