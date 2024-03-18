import 'package:flutter/material.dart';
import 'package:flutter_todo/src/view_models/todo_view_model.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodoViewModel())],
      child: MyApp(settingsController: settingsController)));
}
