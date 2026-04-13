import 'package:flutter/material.dart';
import 'package:github_blog/screens/desktop_widget.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 0, 9, 131),
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(decoration: TextDecoration.underline),
  ),
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: LayoutBuilder(
        builder: (context, constraints) {
          //desktop
          if (constraints.maxWidth < 600) {
            //mobile
          }

          return DesktopWidget();
        },
      ),
    );
  }
}
