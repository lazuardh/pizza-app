import 'package:pizza_app/features/todo/domain/entities/comment.dart';

class CommentModel {
  final int id;
  final String name;
  final String email;
  final String body;

  CommentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  Comment toEntity() => Comment(id: id, name: name, email: email, body: body);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}
