import 'package:communityos/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:communityos/theme/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF7F7FB),
          cardColor: Colors.white,
          primaryColor: const Color(0xFF6C5DD3),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C5DD3),
            brightness: Brightness.light,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black87),
            bodyMedium: TextStyle(color: Colors.black87),
            bodySmall: TextStyle(color: Colors.black54),
          ),
        ),
        darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
        primaryColor: const Color(0xFF6C5DD3),
        colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C5DD3),
        brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white70),
        ),
        ),
          home: const SplashScreen(),
        );
      },
    );
  }
}