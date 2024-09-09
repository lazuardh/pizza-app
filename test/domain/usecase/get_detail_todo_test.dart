import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_detail_todo.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetDetailTodo usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetDetailTodo(mockTodoRepository);
  });

  const testId = 1;

  test('should get todo detail from the repository ', () async {
    when(mockTodoRepository.getTodoWithId(testId)).thenAnswer(
      (_) async => Right(testTodoDetail),
    );

    final result = await usecase.execute(testId);

    expect(result, Right(testTodoDetail));
  });
}
