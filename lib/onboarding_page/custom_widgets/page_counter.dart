import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageCounter extends StatelessWidget {
  const PageCounter({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(64))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: ExpandingDotsEffect(
              expansionFactor: 2,
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Colors.grey[300]!),
          onDotClicked: (index) {
            controller.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          },
        ),
      ),
    );
  }
}
