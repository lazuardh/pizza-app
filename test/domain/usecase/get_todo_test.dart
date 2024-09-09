import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_todo.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetTodo(mockTodoRepository);
  });

  final todos = <Todo>[];

  test(
    'should get list of todos from the repository',
    () async {
      when(mockTodoRepository.fetchDataTodos())
          .thenAnswer((_) async => Right(todos));

      final result = await usecase.execute();

      expect(result, Right(todos));
    },
  );
}
