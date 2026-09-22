import 'package:flutter/material.dart';

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
      title: 'Tugas UI Flutter',
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Roboto'),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeMode,
      home: ResponsiveProfilePage(onThemeChanged: toggleTheme),
    );
  }
}
