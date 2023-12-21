import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 0),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: SvgPicture.asset(
                "assets/svgs/onboarding_1.svg",
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Share Achievements",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 6,
              child: Text(
                "Effortlessly catalog and share your momentous achievements in your student portfolio. Share your GPA, test scores, sports achievements, and more to colleges and perspective employers.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
