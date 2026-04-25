import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:http/http.dart' as http;

class LikeButton extends ConsumerStatefulWidget {
  const LikeButton({super.key, required this.data});
  final EntryData data;

  @override
  ConsumerState<LikeButton> createState() {
    return _LikeButtonState();
  }
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  bool _isSending = false;

  Future<int> _loadLikes() async {
    final url = Uri.https(
      'shoppinglist-81ab6-default-rtdb.firebaseio.com',
      'blog_likes.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400 || response.body == 'null') {
      if (mounted) {
        //If the widget is still on screen.
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: const Text('Error retreiving data')));
      }
      return 0;
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    // response format : {-OqPoJd95Hafu2jrU0Zq: {likes: 0, title: Starting up a blog to share progress!}, -OqPoKl1-QRWpsxsKXGI: {likes: 0, title: Progress report on Flutter development.}}

    int loadedLikes = responseData.entries
        .firstWhere((element) => element.key == widget.data.id)
        .value['likes'];

    // Entries format = MapEntry(-OqPoJd95Hafu2jrU0Zq: {likes: 0, title: Starting up a blog to share progress!})
    if (loadedLikes < 0) {
      print('conversion error');
    }

    widget.data.likes = loadedLikes;
    return loadedLikes;
  }

  void _upLike() async {
    setState(() {
      _isSending = true;
    });

    final url = Uri.https(
      'shoppinglist-81ab6-default-rtdb.firebaseio.com',
      'blog_likes/${widget.data.id}.json',
    );
    final response = await http.patch(
      url,
      //headers: {'Content-type': 'application/json'},
      body: json.encode({'likes': (widget.data.likes + 1)}),
    );

    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      setState(() {
        _isSending = false;
      });
    } else {
      print('Error in posting');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFavourited = ref.watch(favoritedProvider).contains(widget.data);
    final loadedLikes = _loadLikes();

    return Container(
      alignment: Alignment.bottomLeft,
      height: 50,
      width: 700,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: isFavourited
                ? null
                : () {
                    ref
                        .read(favoritedProvider.notifier)
                        .toggleEntryLiked(widget.data);
                    _upLike();
                  },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  fixedCrossAxisSizeFactor: 2,
                  axis: Axis.vertical,
                  child: child,
                );
              },
              child: _isSending
                  ? Center(child: CircularProgressIndicator())
                  : Icon(
                      isFavourited
                          ? Icons.thumb_up
                          : Icons.thumb_up_alt_outlined,
                      key: ValueKey(isFavourited),
                    ),
            ),
          ),
          FutureBuilder(
            future: loadedLikes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 20,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  child: Text(snapshot.data.toString()),
                );
              } else {
                return Container(
                  height: 20,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  child: Text('??'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
