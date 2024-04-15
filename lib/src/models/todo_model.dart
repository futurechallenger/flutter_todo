import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoItem with _$TodoItem {
  const factory TodoItem({
    int? id,
    required String content,
    String? note,
    int? deleted,
    int? status,
  }) = _TodoItem;

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
}

Map<String, dynamic> convertToMap(TodoItem todo) {
  return <String, dynamic>{
    "content": todo.content,
    "note": todo.note,
    "id": todo.id,
    "status": todo.status,
    "deleted": todo.deleted
  };
}

TodoItem convertToTodoItem(Map<String, dynamic> map) {
  return TodoItem(
      id: map['id'],
      content: map['content'],
      note: map['note'],
      status: map['status'],
      deleted: map['deleted']);
}
