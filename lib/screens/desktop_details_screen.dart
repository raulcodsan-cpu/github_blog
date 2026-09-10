import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/services/blog_service.dart';
import 'package:github_blog/widgets/post_details_widget.dart';
import 'package:go_router/go_router.dart';

class DesktopDetailsScreen extends StatefulWidget {
  const DesktopDetailsScreen({
    super.key,
    required this.postId,
    required this.blogService,
    this.initialPost,
  });
  final String postId;
  final BlogPost? initialPost;
  final BlogService blogService;

  @override
  State<DesktopDetailsScreen> createState() => _DesktopDetailsScreenState();
}

class _DesktopDetailsScreenState extends State<DesktopDetailsScreen> {
  late Future<BlogPost?> _postFuture;
  BlogPost? _currentPost;

  @override
  void initState() {
    _currentPost = widget.initialPost;
    if (_currentPost == null) {
      _postFuture = widget.blogService.fetchPostById(widget.postId);
    } else {
      // TODO: Future.value(_currentPost)
      _postFuture = Future.value(_currentPost);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          _currentPost?.title ?? 'Post Details',
          style: TextStyle(fontSize: 40),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: _postFuture,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting &&
                  _currentPost == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final post = asyncSnapshot.data ?? _currentPost;
              if (post == null) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Article not found.'),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => context.go('/'),
                        child: const Text('Back to articles'),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  SizedBox(height: 100),
                  EntryWidget(data: post),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
