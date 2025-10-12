import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/utils/theme/theme_mode.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeModeCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🌙 Dark Mode Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                BlocBuilder<ThemeModeCubit, ThemeData>(
                  builder: (context, theme) {
                    final isDark = theme.brightness == Brightness.dark;
                    return CupertinoSwitch(
                      value: isDark,
                      onChanged: (_) => themeCubit.toggleTheme(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 🌍 Language Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language", style: Theme.of(context).textTheme.titleLarge),
                BlocBuilder<ThemeModeCubit, ThemeData>(
                  builder: (context, theme) {
                    return DropdownButton<Locale>(
                      value: themeCubit.locale,
                      items: const [
                        DropdownMenuItem(
                          value: Locale('en'),
                          child: Text("English"),
                        ),
                        DropdownMenuItem(
                          value: Locale('ar'),
                          child: Text("العربية"),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) themeCubit.changeLanguage(value);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
