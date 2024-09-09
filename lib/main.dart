import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/router/page_router.dart';
import 'package:pizza_app/features/todo/presentation/bloc/comment/comment_bloc.dart';
import 'package:pizza_app/features/todo/presentation/bloc/detail_todo/detail_todo_bloc.dart';
import 'package:pizza_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:pizza_app/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PageRouter router = PageRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<TodoBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTodoBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<CommentBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 253, 253)),
          useMaterial3: true,
        ),
        onGenerateRoute: router.getRoute,
      ),
    );
  }
}
