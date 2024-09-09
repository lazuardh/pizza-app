import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/router/page_path.dart';
import 'package:pizza_app/common/utils/font_utils.dart';
import 'package:pizza_app/common/widgets/custom_wrapper.dart';
import 'package:pizza_app/common/widgets/gap.dart';
import 'package:pizza_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:badges/badges.dart' as badges;

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<CategoryEntity> _categoryList = CategoryEntity.listCategory;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<TodoBloc>().add(OnGetTodosLoaded()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodoHasData) {
          final todos = state.todos;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Bian Notes',
                style: AppTextStyle.semiBold.copyWith(
                  fontSize: 18,
                ),
              ),
              actions: [
                badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -2, end: -2),
                  badgeContent: Container(
                    width: 1,
                    height: 1,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  child: const Icon(
                    Icons.inbox,
                    size: 25,
                  ),
                ),
                const Gap(width: 20)
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          _categoryList.length,
                          (index) {
                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _categoryList[index].category,
                                      style: AppTextStyle.medium.copyWith(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.grey[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ]),
                ),
                Expanded(
                  child: IndexedStack(
                    index: selectedIndex,
                    children: [
                      _notesList(
                        todos: todos,
                      ),
                      Center(
                        child: Text(
                          'Highliht Empty',
                          style: AppTextStyle.semiBold.copyWith(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Favorite Empty',
                          style: AppTextStyle.semiBold.copyWith(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is TodoError) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyle.medium.copyWith(
                fontSize: 16,
              ),
            ),
          );
        } else {
          return Center(
              child: Text(
            'Failed',
            style: AppTextStyle.medium.copyWith(
              fontSize: 16,
            ),
          ));
        }
      },
    );
  }

  Widget _notesList({required List<Todo> todos}) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return _cardTodos(
          title: todos[index].title,
          body: todos[index].body,
          onTap: () => Navigator.pushNamed(
            context,
            PagePath.detailTodo,
            arguments: todos[index],
          ),
        );
      },
    );
  }

  Widget _cardTodos(
      {required String title, required String body, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(239, 83, 80, 1)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ColumnPadding(
          padding: const EdgeInsets.all(10),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyle.bold.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            const Gap(height: 10),
            Text(
              body,
              style: AppTextStyle.medium.copyWith(
                fontSize: 16,
              ),
            ),
            const Gap(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                  text: 'Notes',
                  style: AppTextStyle.medium.copyWith(
                    fontSize: 12,
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
                        fontSize: 12,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                )),
                Text(
                  '9 September 2024',
                  style: AppTextStyle.medium.copyWith(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
