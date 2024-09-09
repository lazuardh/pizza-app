import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_detail_todo.dart';

import '../../../domain/entities/todo.dart';

part 'detail_todo_event.dart';
part 'detail_todo_state.dart';

class DetailTodoBloc extends Bloc<DetailTodoEvent, DetailTodoState> {
  final GetDetailTodo getDetailTodo;
  DetailTodoBloc(this.getDetailTodo) : super(DetailTodoEmpty()) {
    on<OnDetailTodoLoaded>((event, emit) async {
      emit(DetailTodoLoading());

      final result = await getDetailTodo.execute(event.todoId);

      result.fold(
        (failure) => emit(DetailTodoError(failure.message)),
        (todoId) => emit(DetailTodoHasData(todoId)),
      );
    });
  }
}
