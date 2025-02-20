import 'dart:convert';

class ToDoEntity {
  final String title;
  final String description;
  final bool isDone;

  ToDoEntity({
    required this.title,
    required this.description,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'is_done': isDone};
  }

  factory ToDoEntity.fromMap(Map<String, dynamic> map) {
    return ToDoEntity(
      title: map['title'],
      description: map['description'],
      isDone: map['is_done'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ToDoEntity.fromJson(String source) =>
      ToDoEntity.fromMap(jsonDecode(source));
}
