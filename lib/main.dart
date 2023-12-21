import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sky_board/splash_screen/splash_screen.dart';
import 'package:sky_board/themes/light_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://rphoengpbmluulmytwgr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJwaG9lbmdwYm1sdXVsbXl0d2dyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc0Njg5MjQsImV4cCI6MjAxMzA0NDkyNH0.MF3P7FAKXPVGhsfIxuZhTYhs7VL-WNhtVXIgvieZx4c',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkyBoard',
      theme: LightTheme().lightTheme(context),
      home: SplashScreen(),
    );
  }
}
