import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:todo/src/controllers/home_controller.dart';
import 'package:todo/src/pages/home_page.dart';
import 'package:todo/src/todo_repo.dart';
import 'package:utils/utils.dart';

void main() async {
  final calculator = Calculator();
  final calRet = calculator.addOne(1);
  debugPrint('Cal ret:> $calRet');

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
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    // Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
    Get.lazyPut<DetailController>(() => DetailController());
  }
}

class DetailController {}
