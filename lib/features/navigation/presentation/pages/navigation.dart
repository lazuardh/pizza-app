import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_app/features/pizza/presentation/pages/pizza_page.dart';
import 'package:pizza_app/features/todo/presentation/pages/todo_page.dart';

import '../../../../common/utils/colors.dart';
import '../../../../common/utils/size.dart';
import '../../../../common/widgets/scaffold_constraints.dart';
import '../../data/entities/bottom_navigation_entity.dart';

class BottomNavigation extends StatefulWidget {
  final int _selectedIndex;
  const BottomNavigation({
    Key? key,
    int selectedIndex = 0,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _activeIndex = 0;
  final List<BottomNavigationEntity> _bottomNavList =
      BottomNavigationEntity.bottomNavList;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: AppColors.blackPrimary,
      statusBarBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return ScaffoldConstraint(
      keyScaffold: _key,
      onWillPop: () {},
      isBottomNavBar: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _bottomNavigation(ctx),
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _activeIndex,
              children: const [PizzaPage(), TodoPage()],
            ),
          ),
        ],
      ),
    );
  }

  Container _bottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyLighter, width: 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.normal),
            topRight: Radius.circular(AppBorderRadius.normal),
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, -1),
              blurRadius: 0,
              spreadRadius: 0,
              color: AppColors.white,
            )
          ]),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          ...List.generate(
            _bottomNavList.length,
            (index) => BottomNavigationBarItem(
              icon: _bottomNavList[index].icon,
              activeIcon: _bottomNavList[index].iconActive,
              label: _bottomNavList[index].label,
            ),
          )
        ],
        currentIndex: _activeIndex,
        // selectedItemColor: AppColors.purplePrime,
        // unselectedItemColor: AppColors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  Future<void> _onItemTapped(int index, BuildContext ctx) async {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _activeIndex = index;
    });
  }
}
