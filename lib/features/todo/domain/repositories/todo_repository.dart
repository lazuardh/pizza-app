import 'package:dartz/dartz.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/domain/entities/comment.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> fetchDataTodos();
  Future<Either<Failure, Todo>> getTodoWithId(int id);
  Future<Either<Failure, List<Comment>>> fetchDataComments(int id);
}
