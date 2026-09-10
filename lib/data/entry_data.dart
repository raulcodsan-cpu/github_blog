import 'package:flutter_riverpod/legacy.dart';

class BlogPost {
  BlogPost({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.date,
  }) : likes = 0;
  //date = DateTime.now();
  final String id;
  //final DateTime date;
  final String title;
  final String subtitle;
  final String body;
  final DateTime date;
  int likes;

  factory BlogPost.fromJson(Map<String, dynamic> json, {String? docID}) {
    return BlogPost(
      id: docID ?? json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      body: json['body'] as String,
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

/* class FavouritedNotifier extends StateNotifier<List<BlogPost>> {
  FavouritedNotifier() : super([]);

  bool toggleEntryLiked(BlogPost entry) {
    final isLiked = state.contains(entry);

    if (isLiked) {
      state = state
          .where((likedEntries) => likedEntries.id != entry.id)
          .toList();
      return false;
    } else {
      state = [...state, entry];
      return true;
    }
  }
}

final favoritedProvider =
    StateNotifierProvider<FavouritedNotifier, List<BlogPost>>(
      (ref) => FavouritedNotifier(),
    );
 */
