import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_todo.dart';

import '../../../domain/entities/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodo fetchTodos;
  TodoBloc(this.fetchTodos) : super(TodoEmpty()) {
    on<OnGetTodosLoaded>((event, emit) async {
      emit(TodoLoading());

      final result = await fetchTodos.execute();

      result.fold(
        (failure) => emit(TodoError(failure.message)),
        (todos) => emit(TodoHasData(todos)),
      );
    });
  }
}
