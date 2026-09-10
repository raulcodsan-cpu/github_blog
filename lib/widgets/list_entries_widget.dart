import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:go_router/go_router.dart';

class ListEntriesWidget extends StatelessWidget {
  const ListEntriesWidget({super.key, required this.article});
  final BlogPost article;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30),
      ),
      width: 500,
      child: ListTile(
        title: Text(article.title),
        subtitle: Text(article.subtitle),
        onTap: () => context.go('/post/${article.id}', extra: article),
      ),
    );
  }
}
