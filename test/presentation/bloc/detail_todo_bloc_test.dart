import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_detail_todo.dart';
import 'package:pizza_app/features/todo/presentation/bloc/detail_todo/detail_todo_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_todo_bloc_test.mocks.dart';

@GenerateMocks([GetDetailTodo])
void main() {
  late DetailTodoBloc bloc;
  late MockGetDetailTodo mockGetDetailTodo;
  const testId = 1;

  setUp(() {
    mockGetDetailTodo = MockGetDetailTodo();
    bloc = DetailTodoBloc(mockGetDetailTodo);
  });

  test('initial state should be TodoLoading', () {
    expect(bloc.state, DetailTodoEmpty());
  });

  blocTest<DetailTodoBloc, DetailTodoState>(
    'should emit [Loading, hasData] when list data gotten is successfully',
    build: () {
      when(mockGetDetailTodo.execute(testId))
          .thenAnswer((_) async => Right(testTodoDetail));

      return bloc;
    },
    act: (bloc) => bloc.add(const OnDetailTodoLoaded(testId)),
    expect: () => [
      DetailTodoLoading(),
      DetailTodoHasData(testTodoDetail),
    ],
    verify: (bloc) {
      verify(mockGetDetailTodo.execute(testId));
    },
  );

  blocTest<DetailTodoBloc, DetailTodoState>(
    'should emit [Loading, Error] when get data gotten is unsuccessfully',
    build: () {
      when(mockGetDetailTodo.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return bloc;
    },
    act: (bloc) => bloc.add(const OnDetailTodoLoaded(testId)),
    expect: () => [
      DetailTodoLoading(),
      const DetailTodoError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetDetailTodo.execute(testId));
    },
  );
}
