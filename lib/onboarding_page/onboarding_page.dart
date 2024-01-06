import 'package:flutter/material.dart';
import 'package:sky_board/global_widgets/custom_app_bar.dart';
import 'package:sky_board/onboarding_page/custom_widgets/background.dart';
import 'package:sky_board/onboarding_page/custom_widgets/page_1.dart';
import 'package:sky_board/onboarding_page/custom_widgets/page_2.dart';
import 'package:sky_board/onboarding_page/custom_widgets/page_3.dart';
import 'package:sky_board/onboarding_page/custom_widgets/page_back_button.dart';
import 'package:sky_board/onboarding_page/custom_widgets/page_counter.dart';
import 'package:sky_board/onboarding_page/custom_widgets/page_forward_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const OnboardingPage1(),
    const OnboardingPage2(),
    const OnboardingPage3()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: CustomPaint(
        painter: BackgroundPainter(
          primaryColor: Theme.of(context).colorScheme.primary,
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: _pages,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        PageCounter(
                          controller: _pageController,
                          count: 3,
                        ),
                        const Spacer(),
                        PageBackButton(controller: _pageController),
                        const SizedBox(
                          width: 16,
                        ),
                        PageForwardButton(controller: _pageController)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
