/*
  id           Int    @id @default(autoincrement())
  hook         String @default("")
  triggerTypes String @default("") @map("trigger_types") // 1: adding, 2: updating, 3: deleting
  flowId       Int    @map("flow_id")
  deleted      Int    @default(0)
*/
import 'dart:convert';

import 'package:flutter_todo/src/screens/add_todo_item.dart';

class TodoItem {
  final int id;
  final String hook;
  final String triggerTypes;
  final int deleted;

  const TodoItem({
    required this.id,
    required this.hook,
    required this.triggerTypes,
    required this.deleted,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'hook': String hook,
        'triggerTypes': String triggerTypes,
        'deleted': int deleted,
      } =>
        TodoItem(
            id: id, hook: hook, triggerTypes: triggerTypes, deleted: deleted),
      _ => throw const FormatException('Failed to load todo item'),
    };
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'id': id,
      'hook': hook,
      'triggerTypes': triggerTypes,
      'deleted': deleted,
    });
  }
}
