import 'package:dartz/dartz.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/data/datasources/remote_todo_datasource.dart';
import 'package:pizza_app/features/todo/domain/entities/comment.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';
import 'package:pizza_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final RemoteTodoDatasource remoteDatasource;

  TodoRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<Comment>>> fetchDataComments(int id) async {
    try {
      final result = await remoteDatasource.getCommentById(id);
      return Right(result.map((comment) => comment.toEntity()).toList());
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> fetchDataTodos() async {
    try {
      final result = await remoteDatasource.getDataTodos();
      return Right(result.map((model) => model.toEntity()).toList());
    } catch (e) {
      print(e.toString());
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoWithId(int id) async {
    try {
      final result = await remoteDatasource.getTodoById(id);
      return Right(result.toEntity());
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
