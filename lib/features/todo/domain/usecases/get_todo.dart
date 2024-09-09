import 'package:dartz/dartz.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';

class GetTodo {
  final TodoRepository repository;

  GetTodo(this.repository);

  Future<Either<Failure, List<Todo>>> execute() async {
    return await repository.fetchDataTodos();
  }
}
