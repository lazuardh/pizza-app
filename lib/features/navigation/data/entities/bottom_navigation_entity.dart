import 'package:flutter/material.dart';

class BottomNavigationEntity {
  final Widget icon;
  final Widget iconActive;
  final String label;

  BottomNavigationEntity({
    required this.icon,
    required this.iconActive,
    required this.label,
  });

  static List<BottomNavigationEntity> bottomNavList = [
    BottomNavigationEntity(
      icon: const Icon(Icons.shopping_cart_outlined),
      iconActive: const Icon(
        Icons.shopping_cart_outlined,
        color: Colors.blue,
      ),
      label: 'Order Pizza',
    ),
    BottomNavigationEntity(
      icon: const Icon(Icons.note_add_sharp),
      iconActive: const Icon(
        Icons.note_add_sharp,
        color: Colors.blue,
      ),
      label: 'Todo',
    ),
  ];
}
