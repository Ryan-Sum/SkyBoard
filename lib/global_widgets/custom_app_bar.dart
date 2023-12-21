import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: SvgPicture.asset("assets/svgs/logo_horizontal.svg",
            semanticsLabel: 'SkyBoard Logo',
            colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor, BlendMode.srcIn)));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
