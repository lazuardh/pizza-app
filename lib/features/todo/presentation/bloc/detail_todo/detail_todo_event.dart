part of 'detail_todo_bloc.dart';

abstract class DetailTodoEvent extends Equatable {
  const DetailTodoEvent();

  @override
  List<Object> get props => [];
}

class OnDetailTodoLoaded extends DetailTodoEvent {
  final int todoId;

  const OnDetailTodoLoaded(this.todoId);

  @override
  List<Object> get props => [todoId];
}
