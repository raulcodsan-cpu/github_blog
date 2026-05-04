import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/widgets/entry_widget.dart';
import 'package:github_blog/widgets/main_drawer.dart';
import 'package:http/http.dart' as http;

class MobileWidget extends StatefulWidget {
  const MobileWidget({super.key});

  @override
  State<MobileWidget> createState() => _MobileWidgetState();
}

class _MobileWidgetState extends State<MobileWidget> {
  var _activeEntry = 0;
  var isLoading = false;
  late Future<List<EntryData>> _loadedList;

  void _changeEntry(int entryNo) {
    setState(() {
      _activeEntry = entryNo;
    });
  }

  Future<List<EntryData>> _onlineDatabase() async {
    isLoading = true;
    final url = Uri.https(
      'shoppinglist-81ab6-default-rtdb.firebaseio.com',
      'blog_entries.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400 || response.body == 'null') {
      throw Exception('Error retreiving data');
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<EntryData> loadedList = [];
    // response format : {-OqPoJd95Hafu2jrU0Zq: {likes: 0, title: Starting up a blog to share progress!}, -OqPoKl1-QRWpsxsKXGI: {likes: 0, title: Progress report on Flutter development.}}
    for (var resDataEntry in responseData.entries) {
      loadedList.add(
        EntryData(
          id: resDataEntry.key,
          title: resDataEntry.value['title'],
          subtitle: resDataEntry.value['subtitle'],
          body: resDataEntry.value['body'],
          date: DateTime.parse(resDataEntry.value['date']),
        ),
      );
    }
    loadedList.sort((a, b) => b.date.compareTo(a.date));
    return loadedList;
  }

  @override
  void initState() {
    _loadedList = _onlineDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadedList,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: const CircularProgressIndicator()),
          );
        }
        if (asyncSnapshot.hasError) {
          return Scaffold(
            body: Center(child: const Text('Error fetching data')),
          );
        }
        if (!asyncSnapshot.hasData) {
          return Scaffold(body: Center(child: const Text('Database is empty')));
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Flutter Development Blog')),
          drawer: MainDrawer(
            changeEntry: _changeEntry,
            loadedList: asyncSnapshot.data!,
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  EntryWidget(data: asyncSnapshot.data![_activeEntry]),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
