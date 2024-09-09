import 'package:flutter/material.dart';
import 'package:pizza_app/features/pizza/presentation/pages/pizza_page.dart';
import 'package:pizza_app/features/todo/domain/entities/todo.dart';
import 'package:pizza_app/features/todo/presentation/pages/detail_todo.dart';
import 'package:pizza_app/features/todo/presentation/pages/todo_page.dart';

import '../../features/navigation/presentation/pages/navigation.dart';
import 'page_path.dart';

class PageRouter {
  Route<dynamic>? getRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      /* splash */
      //-------------------------------------------------------
      // case PagePath.splash:
      //   return _buildRouter(
      //     settings: settings,
      //     builder: (args) => const SplashScreen(),
      //   );
      //------------------------------------------------------

      // /* Bottom Navigation */
      // //-------------------------------------------------------
      case PagePath.navigation:
        return _buildRouter(
          settings: settings,
          builder: (args) => BottomNavigation(selectedIndex: args as int? ?? 0),
        );
      //------------------------------------------------------

      /* Order Pizza */
      //-------------------------------------------------------
      case PagePath.orderPizza:
        return _buildRouter(
          settings: settings,
          builder: (args) => const PizzaPage(),
        );
      //------------------------------------------------------

      /* Todo Page */
      //-------------------------------------------------------
      case PagePath.todo:
        return _buildRouter(
          settings: settings,
          builder: (args) => const TodoPage(),
        );
      //------------------------------------------------------

      case PagePath.detailTodo:
        final todos = settings.arguments as Todo;
        return _buildRouter(
          settings: settings,
          builder: (args) => DetailTodos(
            todos: todos,
          ),
        );

      default:
        return null;
    }
  }

  Route<dynamic> _buildRouter({
    required RouteSettings settings,
    required Widget Function(Object? arguments) builder,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => builder(settings.arguments),
    );
  }
}
