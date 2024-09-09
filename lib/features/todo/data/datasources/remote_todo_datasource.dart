import 'dart:convert';
import 'dart:developer';

import 'package:pizza_app/common/utils/exeption.dart';
import 'package:pizza_app/features/todo/data/models/comment_model.dart';
import 'package:pizza_app/features/todo/data/models/todo_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteTodoDatasource {
  Future<List<TodoModel>> getDataTodos();
  Future<TodoModel> getTodoById(int id);
  Future<List<CommentModel>> getCommentById(int todoId);
}

class RemoteTodoDatasourceImpl extends RemoteTodoDatasource {
  final http.Client client;

  RemoteTodoDatasourceImpl(this.client);

  @override
  Future<List<TodoModel>> getDataTodos() async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    log("response");
    log(response.body);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((todo) => TodoModel.fromJson(todo)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return TodoModel.fromJson(data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<CommentModel>> getCommentById(int todoId) async {
    final response = await client.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$todoId/comments'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);

      return data.map((comment) => CommentModel.fromJson(comment)).toList();
    } else {
      throw Exception();
    }
  }
}
