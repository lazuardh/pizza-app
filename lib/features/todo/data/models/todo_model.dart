import '../../domain/entities/todo.dart';

class TodoModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }

  Todo toEntity() {
    return Todo(
      userId: userId,
      id: id,
      title: title,
      body: body,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
