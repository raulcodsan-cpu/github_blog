import 'package:flutter/material.dart';
import 'package:github_blog/widgets/entry_widget.dart';
import 'package:github_blog/widgets/main_drawer.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Flutter development blog',
          style: TextStyle(fontSize: 40),
        ),

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 40,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [SizedBox(height: 200), EntryWidget()],
        ),
      ),
    );
  }
}
