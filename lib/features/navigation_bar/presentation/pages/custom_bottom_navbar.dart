import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maw3ed/features/home/presentation/pages/home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: PersistentTabView(
        backgroundColor: Theme.of(context).colorScheme.surface,
        tabs: [
          PersistentTabConfig(
            screen: const HomeScreen(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.house_fill),
              inactiveIcon: const Icon(CupertinoIcons.home),
              title: "Home",
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),
          PersistentTabConfig(
            screen: const Scaffold(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.map_fill),
              inactiveIcon: const Icon(CupertinoIcons.map),
              title: "Maps",
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),
          PersistentTabConfig(
            screen: const Scaffold(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.bell_fill),
              inactiveIcon: const Icon(CupertinoIcons.bell),
              title: "Notifications",
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),
          PersistentTabConfig(
            screen: const Scaffold(),
            item: ItemConfig(
              icon: const Icon(CupertinoIcons.person_fill),
              inactiveIcon: const Icon(CupertinoIcons.person),
              title: "Profile",
              activeForegroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style1BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
