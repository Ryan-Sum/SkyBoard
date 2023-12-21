import 'package:flutter/material.dart';

class PageForwardButton extends StatelessWidget {
  const PageForwardButton({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn2",
      onPressed: () {
        if (controller.page != 2) {
          controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      },
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const CircleBorder(),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
