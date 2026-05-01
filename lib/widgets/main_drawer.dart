import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:intl/intl.dart';

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
    final dateFormatter = DateFormat.yMd();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.only(top: 60, left: 20, right: 20),
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: const Text('Blog Entries', style: TextStyle(fontSize: 20)),
          ),

          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: loadedList.length,
              itemBuilder: (context, index) => ListTile(
                leading: Text(dateFormatter.format(loadedList[index].date)),
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
