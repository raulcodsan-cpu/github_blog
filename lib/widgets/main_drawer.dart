import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.changeEntry,
    required this.loadedList,
  });
  final void Function(int entryNo) changeEntry;
  final List<EntryData> loadedList;

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

          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: loadedList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(loadedList[index].title),
                hoverColor: Theme.of(context).scaffoldBackgroundColor,
                mouseCursor: SystemMouseCursors.click,
                onTap: () {
                  changeEntry(index);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
