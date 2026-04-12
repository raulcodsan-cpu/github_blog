import 'package:flutter/material.dart';
import 'package:github_blog/widgets/desktop_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //desktop
        if (constraints.maxWidth < 600) {
          //mobile
        }

        return DesktopWidget();
      },
    );
  }
}
