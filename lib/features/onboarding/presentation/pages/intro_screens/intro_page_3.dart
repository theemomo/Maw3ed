import 'package:flutter/material.dart';
import 'package:maw3ed/features/onboarding/presentation/widgets/intro_content_widget.dart';
import 'package:maw3ed/generated/l10n.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroContentWidget(
      title: S.of(context).introPage3Title,
      description:
          S.of(context).introPage3Description,
      imagePath:
          'https://lottie.host/28899bb1-f078-4d4e-ae64-cadea68bba11/j1VkgPhEmu.json',
      backgroundColor: const Color(0xFFB9E5D3),
    );
  }
}
