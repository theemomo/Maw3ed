import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/core/utils/theme/theme_mode.dart';
import 'package:maw3ed/features/onboarding/presentation/pages/intro_screens/intro_page_1.dart';
import 'package:maw3ed/features/onboarding/presentation/pages/intro_screens/intro_page_2.dart';
import 'package:maw3ed/features/onboarding/presentation/pages/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final ThemeModeCubit themeCubit = context.read<ThemeModeCubit>();
    return Scaffold(
      body: Stack(
        children: [
          // PAGES
          PageView(
            controller: _controller,
            onPageChanged: (pageIndex) {
              setState(() {
                onLastPage = pageIndex == 2;
              });
            },
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
          ),

          // LANGUAGE DROPDOWN (TOP-RIGHT)
          Positioned(
            top: 50,
            right: 20,
            child: BlocBuilder<ThemeModeCubit, ThemeData>(
              builder: (context, theme) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Locale>(
                      value: themeCubit.locale,

                      dropdownColor: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      items: const [
                        DropdownMenuItem(
                          value: Locale('en'),
                          child: Row(
                            children: [
                              Icon(Icons.language, color: Colors.blueAccent),
                              SizedBox(width: 8),
                              Text("English"),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: Locale('ar'),
                          child: Row(
                            children: [
                              Icon(Icons.language, color: Colors.green),
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
          ),

          // BOTTOM CONTROLS
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip button
                TextButton(
                  onPressed: () => _controller.jumpToPage(2),
                  child: Text(
                    "Skip",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                  ),
                ),

                // dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // next or done button
                onLastPage
                    ? TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.loginRoute);
                        },
                        child: Text(
                          "Done",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          "Next",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
