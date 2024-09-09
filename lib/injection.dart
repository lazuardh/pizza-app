import 'package:get_it/get_it.dart';
import 'package:pizza_app/features/todo/data/datasources/remote_todo_datasource.dart';
import 'package:pizza_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:pizza_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_comment.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_detail_todo.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_todo.dart';
import 'package:pizza_app/features/todo/presentation/bloc/comment/comment_bloc.dart';
import 'package:pizza_app/features/todo/presentation/bloc/detail_todo/detail_todo_bloc.dart';
import 'package:pizza_app/features/todo/presentation/bloc/todo/todo_bloc.dart';

import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  /* ========================= bloc ========================== */
  locator.registerFactory(
    () => TodoBloc(locator()),
  );
  locator.registerFactory(
    () => CommentBloc(locator()),
  );
  locator.registerFactory(
    () => DetailTodoBloc(locator()),
  );

  /* ========================= Use Case ========================== */
  locator.registerLazySingleton(
    () => GetComment(locator()),
  );
  locator.registerLazySingleton(
    () => GetDetailTodo(locator()),
  );
  locator.registerLazySingleton(
    () => GetTodo(locator()),
  );

  locator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(remoteDatasource: locator()),
  );

  locator.registerLazySingleton<RemoteTodoDatasource>(
    () => RemoteTodoDatasourceImpl(locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}
