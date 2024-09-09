import 'package:dartz/dartz.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';
import 'package:pizza_app/features/todo/domain/repositories/todo_repository.dart';

class GetDetailTodo {
  final TodoRepository repository;

  GetDetailTodo(this.repository);

  Future<Either<Failure, Todo>> execute(int todoId) async {
    return await repository.getTodoWithId(todoId);
  }
}
