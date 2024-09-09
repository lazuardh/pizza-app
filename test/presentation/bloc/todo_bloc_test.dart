import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pizza_app/common/utils/failure.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_todo.dart';
import 'package:pizza_app/features/todo/presentation/bloc/todo/todo_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'todo_bloc_test.mocks.dart';

@GenerateMocks([GetTodo])
void main() {
  late TodoBloc bloc;
  late MockGetTodo mockGetTodo;

  setUp(() {
    mockGetTodo = MockGetTodo();
    bloc = TodoBloc(mockGetTodo);
  });

  test('initial state should be TodoLoading', () {
    expect(bloc.state, TodoEmpty());
  });

  blocTest<TodoBloc, TodoState>(
    'should emit [Loading, HasData] when list todo gotten is successfully',
    build: () {
      when(mockGetTodo.execute()).thenAnswer(
        (_) async => Right(testTodosList),
      );

      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTodosLoaded()),
    expect: () => [
      TodoLoading(),
      TodoHasData(testTodosList),
    ],
    verify: (bloc) {
      verify(mockGetTodo.execute());
    },
  );

  blocTest<TodoBloc, TodoState>(
    'should emit [Loading, Error] when list data gotten is unsuccessfully',
    build: () {
      when(mockGetTodo.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTodosLoaded()),
    expect: () => [
      TodoLoading(),
      const TodoError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTodo.execute());
    },
  );
}
