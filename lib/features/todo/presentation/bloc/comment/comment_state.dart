part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentEmpty extends CommentState {}

class CommentLoading extends CommentState {}

class CommentHasData extends CommentState {
  final List<Comment> comment;

  const CommentHasData(this.comment);

  @override
  List<Object> get props => [comment];
}

class CommentError extends CommentState {
  final String message;

  const CommentError(this.message);

  @override
  List<Object> get props => [message];
}
