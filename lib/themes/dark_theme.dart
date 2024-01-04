// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DarkTheme {
  ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.light,
        primary: Color(0xFF1FC5DD),
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFa0efff),
        onPrimaryContainer: Color(0xff001f25),
        secondary: Color(0xFFDD1F66),
        onSecondary: Colors.white,
        secondaryContainer: Color(0x000000ff),
        onSecondaryContainer: Color(0x000000ff),
        tertiary: Color(0xFFE6AC4A),
        onTertiary: Colors.white,
        tertiaryContainer: Color(0x000000ff),
        onTertiaryContainer: Color(0x000000ff),
        error: Color(0xFFba1a1a),
        onError: Color(0xFFffffff),
        errorContainer: Color(0xFFffdad6),
        onErrorContainer: Color(0xFF410002),
        background: Color(0xFF191c1d),
        onBackground: Color(0xFFfbfcfd),
        surface: Color(0xFF191c1d),
        onSurface: Color(0xFFfbfcfd),
        surfaceVariant: Color(0xFF3f484a),
        onSurfaceVariant: Color(0xFFdbe4e6),
        outline: Color(0xFF6f797b),
      ),
      fontFamily: "Roboto",
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height / 850 * 40,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
        ),
        titleMedium: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height / 850 * 24,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
        ),
        titleSmall: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height / 850 * 24,
          fontWeight: FontWeight.w500,
          letterSpacing: -1.0,
        ),
        bodyLarge: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height / 850 * 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height / 850 * 14,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          fontSize: MediaQuery.sizeOf(context).height / 850 * 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            enableFeedback: true,
            elevation: const MaterialStatePropertyAll<double>(0),
            textStyle: MaterialStatePropertyAll<TextStyle>(
              Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            minimumSize: MaterialStatePropertyAll<Size>(
                Size(MediaQuery.of(context).size.width * 0.8, 50))),
      ),
    );
  }
}
