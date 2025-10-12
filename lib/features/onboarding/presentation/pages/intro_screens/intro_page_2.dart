import 'package:flutter/material.dart';
import 'package:maw3ed/features/onboarding/presentation/widgets/intro_content_widget.dart';
import 'package:maw3ed/generated/l10n.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroContentWidget(
      title: S.of(context).introPage2Title,
      description:
          S.of(context).introPage2Description,
      imagePath:
          'https://lottie.host/80f6b6aa-69dd-419f-9d36-4ca1adb4ad0b/6qeeePslSp.json',
      backgroundColor: const Color(0xFFD7C3F1),
    );
  }
}
