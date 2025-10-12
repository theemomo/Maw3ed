import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/utils/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// It extends Cubit<ThemeData>, meaning it’s a Cubit that manages and emits ThemeData objects (which define your app’s theme).
class ThemeModeCubit extends Cubit<ThemeData> {
  // You have to give the Cubit<ThemeData> constructor a parameter of ThemeData
  ThemeModeCubit() : super(AppTheme.getLightTheme(const Locale('en')));

  final String _languageKey = 'app_language';
  final String _themeKey = 'app_theme';

  Locale _locale = const Locale('en');
  bool _isDark = false;

  Locale get locale => _locale;
  bool get isDark => _isDark;

  Future<void> init() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    // Load theme (default to false = light)
    _isDark = preferences.getBool(_themeKey) ?? false;
    // print(_isDark);

    // Load locale (default to 'en')
    final String? savedLocale = preferences.getString(_languageKey);
    _locale = Locale(savedLocale ?? 'en');
    // print(_locale);

    // Emit the loaded theme
    emit(
      _isDark
          ? AppTheme.getDarkTheme(_locale)
          : AppTheme.getLightTheme(_locale),
    );
  }

  // Toggle light/dark mode
  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(_themeKey, _isDark);
    emit(
      _isDark
          ? AppTheme.getDarkTheme(_locale)
          : AppTheme.getLightTheme(_locale),
    );
  }

  // Change language
  Future<void> changeLanguage(Locale newLocale) async {
    _locale = newLocale;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_languageKey, _locale.languageCode);
    emit(
      _isDark
          ? AppTheme.getDarkTheme(_locale)
          : AppTheme.getLightTheme(_locale),
    );
  }
}
