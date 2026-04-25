import 'package:flutter_riverpod/legacy.dart';

class EntryData {
  EntryData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.likes,
  });
  //date = DateTime.now();
  final String id;
  //final DateTime date;
  final String title;
  final String subtitle;
  final String body;
  int likes;
}

/* final List<EntryData> _database = [
  EntryData(
    title: 'Starting up a blog to share progress!',
    subtitle: 'Hi!',
    body:
        "I am setting this up just to share my progress in Flutter development. \n\nPlease be kind. \n\nRegards,\nRaul",
  ),
  EntryData(
    title: 'Progress report on Flutter development.',
    subtitle: 'Apps with multi-screen, Screen Stack, and return with PopScope.',
    body:
        'Since the start of my Flutter journey, I have learnt to change "Screens" by changing the shwon widget in a Scaffold by passing functions through Widget classes and receiving input from there.\n\nLearning to use the Screen Stack felt like finally learning how to ride a bike without training wheels.\nSeparately, I am improving the quizz app made in this course with the materials learnt in the ongoing lectures, and I am eager to implement the screen-stack into it.\n\nHowever, after pushing several screens of quizzes I wonder how to transition to the results screen efficiently.\nUsing the screen-stack seems not a good choice compared to the original design, other than for practice and to be able to implement how to go back to previously answered questions. In this instance, I believe PopScope can help me pop a screen while still "remembering" the selected prior answer.\n\nI am also considering to implement the not-recommended named routes, so I can make a "hard route" of Level Selection => Quizz screen-stack => Result screen."',
  ),
]; */

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
