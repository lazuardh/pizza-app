import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_app/features/todo/domain/usecases/get_comment.dart';

import '../../../domain/entities/comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetComment getComments;
  CommentBloc(this.getComments) : super(CommentEmpty()) {
    on<OnCommentLoaded>((event, emit) async {
      emit(CommentLoading());

      final result = await getComments.execute(event.id);

      result.fold(
        (failure) => emit(CommentError(failure.message)),
        (comment) => emit(CommentHasData(comment)),
      );
    });
  }
}
