import 'package:flutter/material.dart';
import 'package:maw3ed/features/onboarding/presentation/widgets/intro_content_widget.dart';
import 'package:maw3ed/generated/l10n.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroContentWidget(
      title: S.of(context).introPage1Title,
      description:
          S.of(context).introPage1Description,
      imagePath:
          'https://lottie.host/6050d248-b0a3-4ac0-86ad-7eed5dceebba/zUClnIMi4a.json',
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
