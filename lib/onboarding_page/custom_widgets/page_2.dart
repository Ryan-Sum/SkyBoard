import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
                "assets/svgs/onboarding_2.svg",
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Expanded(
              flex: 3,
              child: Text(
                "Connect With Your School",
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
                "Join clubs, see news, and explore your school. All from one app! Join your school’s community and stay connected with the most up-to-date information right at your finger tips.",
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
