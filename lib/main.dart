import 'package:flutter/material.dart';
import 'package:github_blog/widgets/main_screen.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 131, 57, 0),
    brightness: Brightness.dark,
  ),
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: MainScreen());
  }
}
