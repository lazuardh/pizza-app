import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pizza_app/features/todo/domain/entities/comment.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_comment.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetComment usecase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    usecase = GetComment(mockTodoRepository);
  });

  const testId = 1;
  final detailTodos = <Comment>[];

  test('shoudl get list comment todo from the repository', () async {
    when(mockTodoRepository.fetchDataComments(testId)).thenAnswer(
      (_) async => Right(detailTodos),
    );

    final result = await usecase.execute(testId);

    expect(result, Right(detailTodos));
  });
}
