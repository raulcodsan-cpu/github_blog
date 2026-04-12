import 'package:flutter/material.dart';
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
        title: Center(
          child: const Text(
            'Flutter development blog',
            style: TextStyle(fontSize: 40),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 300),
            SizedBox(
              width: screenWidth - 100,
              child: Container(
                constraints: BoxConstraints.expand(height: 100),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Text('Todays Entry', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
