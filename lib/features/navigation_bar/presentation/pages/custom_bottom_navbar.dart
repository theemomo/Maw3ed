import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maw3ed/features/home/presentation/pages/home_screen.dart';
import 'package:maw3ed/features/map/presentation/pages/map_screen.dart';
import 'package:maw3ed/features/profile/presentation/pages/profile_screen.dart';
import 'package:maw3ed/generated/l10n.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MapScreen(), // Maps placeholder
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home),
            activeIcon: const Icon(CupertinoIcons.house_fill),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.map),
            activeIcon: const Icon(CupertinoIcons.map_fill),
            label: S.of(context).maps,
          ),
          
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person),
            activeIcon: const Icon(CupertinoIcons.person_fill),
            label: S.of(context).profile,
          ),
        ],
      ),
    );
  }
}
