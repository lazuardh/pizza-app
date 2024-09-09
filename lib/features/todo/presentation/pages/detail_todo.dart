import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/widgets/custom_wrapper.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';
import 'package:pizza_app/features/todo/presentation/bloc/comment/comment_bloc.dart';
import 'package:pizza_app/features/todo/presentation/bloc/detail_todo/detail_todo_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/utils/font_utils.dart';
import '../../../../common/widgets/gap.dart';
import '../../domain/entities/comment.dart';

class DetailTodos extends StatefulWidget {
  final Todo todos;
  const DetailTodos({super.key, required this.todos});

  @override
  State<DetailTodos> createState() => _DetailTodosState();
}

class _DetailTodosState extends State<DetailTodos> {
  bool isExpanded = false; // Tambahkan ini untuk mengontrol tampilan

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<DetailTodoBloc>().add(OnDetailTodoLoaded(widget.todos.id));
        context.read<CommentBloc>().add(OnCommentLoaded(widget.todos.userId));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailTodoBloc, DetailTodoState>(
      builder: (context, state) {
        if (state is DetailTodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DetailTodoHasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Detail Notes',
                style: AppTextStyle.semiBold.copyWith(
                  fontSize: 18,
                ),
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.clear_rounded),
              ),
            ),
            body: ColumnPadding(
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  state.detailTodo.title,
                  style: AppTextStyle.semiBold.copyWith(
                    fontSize: 24,
                  ),
                ),
                const Gap(height: 10),
                _subDetailNotes(),
                const Gap(height: 10),
                Text(
                  state.detailTodo.body,
                  style: AppTextStyle.regular.copyWith(fontSize: 14),
                ),
                const Gap(height: 10),
                const Divider(thickness: 2),
                const Gap(height: 5),
                Text(
                  'Commentar',
                  style: AppTextStyle.regular.copyWith(fontSize: 15),
                ),
                Expanded(
                  child: BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      if (state is CommentLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CommentHasData) {
                        final comments = state.comment;
                        final int displayCount =
                            isExpanded ? comments.length : 4;

                        return Column(
                          children: [
                            _commentsWrapper(displayCount, comment: comments),
                            if (comments.length > 2)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(isExpanded ? 'Less' : 'More'),
                              ),
                          ],
                        );
                      } else if (state is CommentError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return const Center(
                          child: Text('Failed Load Comment'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is DetailTodoError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Failed'),
          );
        }
      },
    );
  }

  Widget _commentsWrapper(int? displayCount, {required List<Comment> comment}) {
    return Expanded(
        child: ListView.builder(
      itemCount: displayCount,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            CircleAvatar(
              backgroundColor: Colors.blue[400],
              child: Text(
                comment[index].email.substring(0, 1),
                style: AppTextStyle.medium
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
            const Gap(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                comment[index].email,
                style: AppTextStyle.medium.copyWith(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 158, 155, 155),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ReadMoreText(
                  comment[index].body,
                  trimMode: TrimMode.Line,
                  trimLines: 3,
                  colorClickableText: Colors.blue,
                  trimCollapsedText: ' Show More',
                  trimExpandedText: ' Show Less',
                  moreStyle: AppTextStyle.regular.copyWith(fontSize: 14),
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.75,
              //   child: Text(
              //     comment[index].body,
              //     style: AppTextStyle.medium.copyWith(
              //       fontSize: 14,
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //     maxLines: 2,
              //   ),
              // ),
            ]),
          ]),
        );
      },
    ));
  }

  Row _subDetailNotes() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text.rich(TextSpan(
        text: 'Notes',
        style: AppTextStyle.medium.copyWith(
          fontSize: 14,
          color: Colors.grey[400],
        ),
        children: [
          TextSpan(
            text: ' | ',
            style: AppTextStyle.medium.copyWith(
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
          TextSpan(
            text: 'Indonesia',
            style: AppTextStyle.medium.copyWith(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          )
        ],
      )),
      Text(
        'Edit Label',
        style: AppTextStyle.semiBold.copyWith(
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    ]);
  }
}
