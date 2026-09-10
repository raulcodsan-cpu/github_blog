import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.futureList});
  final Future<List<BlogPost>> futureList;

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
            child: FutureBuilder(
              future: futureList,
              builder: (context, asyncSnapshot) {
                final posts = asyncSnapshot.data ?? [];
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text(dateFormatter.format(posts[index].date)),
                    title: Text(posts[index].title),
                    hoverColor: Theme.of(context).scaffoldBackgroundColor,
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () {
                      context.go(
                        '/post/${posts[index].id}',
                        extra: posts[index],
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
