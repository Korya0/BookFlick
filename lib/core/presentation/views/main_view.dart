import 'package:bookna_app/core/resources/app_routes.dart';
import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  final Widget child;

  const MainView({super.key, required this.child});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<NavItemModel> _navItems = [
    const NavItemModel(
      label: AppStrings.books,
      icon: Icons.book,
      routeName: AppRoutes.books,
    ),
    const NavItemModel(
      label: AppStrings.category,
      icon: Icons.category_rounded,
      routeName: AppRoutes.category,
    ),
    const NavItemModel(
      label: AppStrings.search,
      icon: Icons.search_rounded,
      routeName: AppRoutes.search,
    ),
    const NavItemModel(
      label: AppStrings.favorite,
      icon: Icons.favorite_rounded,
      routeName: AppRoutes.favorite,
    ),
  ];

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    for (int i = 0; i < _navItems.length; i++) {
      if (location.startsWith('/${_navItems[i].routeName}')) {
        return i;
      }
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    final routeName = _navItems[index].routeName;
    if (GoRouterState.of(context).uri.toString() != '/$routeName') {
      context.goNamed(routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  BottomNavigationBar _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items:
          _navItems
              .map(
                (item) => BottomNavigationBarItem(
                  label: item.label,
                  icon: Icon(item.icon),
                ),
              )
              .toList(),
      currentIndex: _getSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
      type: BottomNavigationBarType.fixed,
    );
  }
}

class NavItemModel {
  final String label;
  final IconData icon;
  final String routeName;

  const NavItemModel({
    required this.label,
    required this.icon,
    required this.routeName,
  });
}
