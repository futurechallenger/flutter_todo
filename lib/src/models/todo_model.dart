import 'dart:convert';

class TodoItem {
  final int id;
  final String content;
  final int deleted;
  final int status;

  const TodoItem({
    required this.id,
    required this.content,
    required this.status,
    required this.deleted,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'content': String content,
        'status': int status,
        'deleted': int deleted,
      } =>
        TodoItem(id: id, content: content, status: status, deleted: deleted),
      _ => throw const FormatException('Failed to load todo item'),
    };
  }

  String toJson() {
    return jsonEncode(<String, dynamic>{
      'id': id,
      'content': content,
      'status': status,
      'deleted': deleted,
    });
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "content": content,
      "id": id,
      "status": status,
      "deleted": deleted
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
        id: map['id'],
        content: map['content'],
        status: map['status'],
        deleted: map['deleted']);
  }
}
