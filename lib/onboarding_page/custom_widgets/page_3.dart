import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sky_board/login_page/login_page.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

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
                "Let’s Get Set Up",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 6,
              child: Column(children: [
                ElevatedButton(onPressed: () {}, child: const Text("Sign Up")),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: const Text("Sign In")),
              ]),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
