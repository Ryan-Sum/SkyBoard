import 'package:flutter/material.dart';

class PageBackButton extends StatelessWidget {
  const PageBackButton({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn1",
      onPressed: () {
        if (controller.page != 0) {
          controller.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      },
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: const CircleBorder(),
      child: Icon(
        Icons.arrow_back_ios_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
