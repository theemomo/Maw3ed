
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:maw3ed/features/auth/presentation/pages/login_screen.dart';
import 'package:maw3ed/features/auth/presentation/pages/register_screen.dart';
import 'package:maw3ed/features/home/presentation/pages/home_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginRoute:
        return fadeRoute(
          BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginScreen(),
          ),
        );
      case AppRoutes.registerRoute:
        return fadeRoute(
          BlocProvider(
            create: (context) => AuthCubit(),
            child: const RegisterScreen(),
          ),
        );
      case AppRoutes.homeRoute:
        return fadeRoute(
          const HomeScreen()
        );


      default:
        return fadeRoute(
          const Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }

  Route fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
