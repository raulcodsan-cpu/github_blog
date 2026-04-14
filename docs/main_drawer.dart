import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_blog/data/entry_data.dart';

class MainDrawer extends ConsumerWidget {
  MainDrawer({super.key, required this.changeEntry});
  void Function(int entryNo) changeEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<EntryData> entryList = ref.read(databaseProvider);

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
              itemCount: entryList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(entryList[index].title),
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
