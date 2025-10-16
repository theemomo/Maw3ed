import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_router.dart';
import 'package:maw3ed/core/utils/theme/theme_mode.dart';
import 'package:maw3ed/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:maw3ed/features/navigation_bar/presentation/pages/custom_bottom_navbar.dart';
import 'package:maw3ed/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:maw3ed/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final themeCubit = ThemeModeCubit();
  await themeCubit.init(); // loads saved theme + language

  runApp(
    BlocProvider.value(
      value: themeCubit, // reuse the already-initialized cubit
      child: const MyApp(),
    ),
  );
  // Note: if you run the app and then call the function it will be the default at first
  //       Then it with change in milliseconds to the settings saved in shared preferences
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeCubit, ThemeData>(
      builder: (context, theme) {
        return BlocProvider(
          create: (context) => AuthCubit()..checkAuthStatus(),
          child: Builder(
            builder: (context) {
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return MaterialApp(
                    locale: context.read<ThemeModeCubit>().locale,
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    theme: theme,
                    onGenerateRoute: AppRouter().onGenerateRoute,
                    // home: const SettingsScreen(),
                    home: state is Authenticated
                        ? const CustomBottomNavbar()
                        : kIsWeb
                        ? const CustomBottomNavbar()
                        : const OnboardingScreen(),
                  );
                },
              );
            }
          ),
        );
      },
    );
  }
}
