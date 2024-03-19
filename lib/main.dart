import 'package:flutter/material.dart';
import 'package:flutter_todo/src/controllers/home_controller.dart';
import 'package:flutter_todo/src/controllers/detail_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  // runApp(MultiProvider(
  //     providers: [ChangeNotifierProvider(create: (context) => TodoViewModel())],
  //     child: MyApp(settingsController: settingsController)));
  runApp(GetxApplication(child: MyApp(settingsController: settingsController)));
}

class GetxApplication extends StatelessWidget {
  const GetxApplication({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetxBindings(),
      home: child,
    );
  }
}

class GetxBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DetailController());
  }
}
