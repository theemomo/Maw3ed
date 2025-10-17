import 'package:flutter/material.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/home/presentation/widgets/calender_content.dart';
import 'package:maw3ed/features/home/presentation/widgets/today_content.dart';
import 'package:maw3ed/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0, right: 30, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton(
                  label: S.of(context).today,
                  isSelected: selectedTab == 0,
                  onTap: () => setState(() => selectedTab = 0),
                  context: context,
                ),
                _buildTabButton(
                  label: S.of(context).calender,
                  isSelected: selectedTab == 1,
                  onTap: () => setState(() => selectedTab = 1),
                  context: context,
                ),
                // Add button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.addEventRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    side: const BorderSide(width: 0.7, color: Colors.grey),
                    minimumSize: const Size(50, 50),
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: selectedTab == 0
                  ? const TodayContent()
                  : const CalenderContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(20, 50),
        shadowColor: Colors.transparent,
        side: BorderSide(
          width: 0.7,
          color: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.onSurface,
      ),
      child: Text(label),
    );
  }
}
