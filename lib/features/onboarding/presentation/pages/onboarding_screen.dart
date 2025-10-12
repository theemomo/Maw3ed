import 'package:flutter/material.dart';
import 'package:maw3ed/core/route/app_routes.dart';
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
  // controller to keep track of witch page we're on
  final PageController _controller = PageController();

  // keep track if we are in the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (pageIndex) {
              if (pageIndex == 2) {
                setState(() {
                  onLastPage = true;
                });
              } else {
                setState(() {
                  onLastPage = false;
                });
              }
            },
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
          ),

          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip button
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.black),
                  ),
                ),

                // dot indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // next button
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
