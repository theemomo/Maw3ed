import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/core/utils/theme/theme_mode.dart';
import 'package:maw3ed/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:maw3ed/generated/l10n.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeModeCubit themeCubit = context.read<ThemeModeCubit>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: const Text('Settings')),
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              width: double.infinity,
              height: size.height * 0.35,
              child: Padding(
                padding: EdgeInsets.only(bottom: size.width * 0.16),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Icon(Icons.person, size: size.width * 0.15),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.28),
              padding: const EdgeInsets.only(
                top: 50,
                right: 20,
                left: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).darkMode,
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
                      Text(
                        S.of(context).language,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      BlocBuilder<ThemeModeCubit, ThemeData>(
                        builder: (context, theme) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Locale>(
                                value: themeCubit.locale,
                                
                                dropdownColor: Theme.of(
                                  context,
                                ).colorScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                                items: const [
                                  DropdownMenuItem(
                                    value: Locale('en'),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(width: 8),
                                        Text("English"),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: Locale('ar'),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.language,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 8),
                                        Text("العربية"),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    themeCubit.changeLanguage(value);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  BlocConsumer<AuthCubit, AuthState>(
                    listenWhen: (previous, current) =>
                        current is AuthFailure || current is Unauthenticated,
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red[900],
                              duration: const Duration(seconds: 3),
                            ),
                          );
                      } else if (state is Unauthenticated) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.loginRoute,
                          (route) => false,
                        );
                      }
                    },
                    buildWhen: (previous, current) => current is AuthLoading,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              206,
                              38,
                              38,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            minimumSize: Size(
                              double.infinity,
                              size.height * 0.06,
                            ),
                          ),
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context).logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            206,
                            38,
                            38,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          minimumSize: Size(
                            double.infinity,
                            size.height * 0.06,
                          ),
                        ),
                        child: Text(
                          S.of(context).logout,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
