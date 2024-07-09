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
import 'package:calendar_plugin/calendar_plugin.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    );

    return GetMaterialApp(
      theme: lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      // ],
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
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
