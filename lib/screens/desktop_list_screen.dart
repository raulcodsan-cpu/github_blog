import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/services/blog_service.dart';
import 'package:github_blog/widgets/list_entries_widget.dart';
import 'package:github_blog/widgets/main_drawer.dart';

class DesktopScreenList extends StatefulWidget {
  const DesktopScreenList({super.key, required this.blogService});
  final BlogService blogService;

  @override
  State<DesktopScreenList> createState() => _DesktopScreenListState();
}

class _DesktopScreenListState extends State<DesktopScreenList> {
  late Future<List<BlogPost>> _postsFuture;

  @override
  void initState() {
    _postsFuture = widget.blogService.fetchPosts();
    super.initState();
  }

  void _reload() {
    setState(() {
      _postsFuture = widget.blogService.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text('Flutter development blog', style: TextStyle(fontSize: 40)),

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 40,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MainDrawer(futureList: _postsFuture),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
          child: Center(
            child: FutureBuilder(
              future: _postsFuture,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (asyncSnapshot.hasError) {}

                final posts = asyncSnapshot.data ?? [];
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return ListEntriesWidget(article: post);
                  },
                  separatorBuilder: (_, _) => const Divider(height: 20),
                  itemCount: posts.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
