import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/add_event/presentation/cubits/add_event_cubit/add_event_cubit.dart';
import 'package:maw3ed/features/add_event/presentation/pages/add_event_screen.dart';
import 'package:maw3ed/features/add_event/presentation/pages/select_location_screen.dart';
import 'package:maw3ed/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:maw3ed/features/auth/presentation/pages/login_screen.dart';
import 'package:maw3ed/features/auth/presentation/pages/register_screen.dart';
import 'package:maw3ed/features/event_details/presentation/pages/event_details_screen.dart';
import 'package:maw3ed/features/event_details/presentation/pages/find_route_screen.dart';
import 'package:maw3ed/features/navigation_bar/presentation/pages/custom_bottom_navbar.dart';
import 'package:maw3ed/features/settings/pages/settings_screen.dart';

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
        return fadeRoute(const CustomBottomNavbar());

      case AppRoutes.addEventRoute:
        return fadeRoute(
          BlocProvider(
            create: (context) => AddEventCubit(),
            child: const AddEventScreen(),
          ),
        );

      case AppRoutes.selectLocationRoute:
        return fadeRoute(const SelectLocationScreen());

      case AppRoutes.settingsRoute:
        return fadeRoute(const SettingsScreen());

      case AppRoutes.eventDetailsRoute:
        final args = settings.arguments as Map;
        final event = args['event'];
        final backgroundColor = args['backgroundColor'];
        return fadeRoute(
          EventDetailsScreen(event: event, backgroundColor: backgroundColor),
        );

      case AppRoutes.findLocationRoute:
        final LatLng location = settings.arguments as LatLng;
        return fadeRoute(FindRouteScreen(location: location));

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
