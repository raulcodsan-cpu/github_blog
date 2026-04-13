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
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: const Text('Blog Entries'),
          ),
          ListTile(title: const Text('Entry 1')),
        ],
      ),
    );
  }
}
