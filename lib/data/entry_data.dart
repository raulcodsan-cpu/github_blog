import 'package:flutter_riverpod/legacy.dart';

class EntryData {
  EntryData({
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
}

class FavouritedNotifier extends StateNotifier<List<EntryData>> {
  FavouritedNotifier() : super([]);

  bool toggleEntryLiked(EntryData entry) {
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
    StateNotifierProvider<FavouritedNotifier, List<EntryData>>(
      (ref) => FavouritedNotifier(),
    );
