import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            child: const Text('Blog Entries'),
          ),
          ListTile(title: const Text('Entry 1')),
        ],
      ),
    );
  }
}
