part of 'detail_todo_bloc.dart';

abstract class DetailTodoState extends Equatable {
  const DetailTodoState();

  @override
  List<Object> get props => [];
}

class DetailTodoEmpty extends DetailTodoState {}

class DetailTodoLoading extends DetailTodoState {}

class DetailTodoHasData extends DetailTodoState {
  final Todo detailTodo;

  const DetailTodoHasData(this.detailTodo);

  @override
  List<Object> get props => [];
}

class DetailTodoError extends DetailTodoState {
  final String message;

  const DetailTodoError(this.message);

  @override
  List<Object> get props => [message];
}
