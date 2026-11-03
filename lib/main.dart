import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'assets_media.dart';
import 'detail_page.dart';
import 'responsive_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assets Media & Navigation',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // 1. Rute awal (halaman pertama saat app dibuka)
      initialRoute: '/',

      // 2. Named Routes
      routes: {
        '/': (context) => const AssetsMediaPage(),
        '/detail': (context) => const DetailPage(),
        // Halaman dari pertemuan sebelumnya, tidak const karena membawa callback
        '/profile': (context) =>
            ResponsiveProfilePage(onThemeChanged: toggleTheme),
      },
    );
  }
}
