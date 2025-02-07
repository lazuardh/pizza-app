import 'package:dartz/dartz.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:pizza_app/features/todo/domain/entities/comment.dart';

class GetComment {
  final TodoRepository repository;

  GetComment(this.repository);

  Future<Either<Failure, List<Comment>>> execute(int todoId) async {
    return await repository.fetchDataComments(todoId);
  }
}
