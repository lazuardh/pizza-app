part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class OnCommentLoaded extends CommentEvent {
  final int id;

  const OnCommentLoaded(this.id);

  @override
  List<Object> get props => [];
}
