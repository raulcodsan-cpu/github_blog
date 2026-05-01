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
  final List<EntryData> _loadedList = [];

  void _changeEntry(int entryNo) {
    setState(() {
      _activeEntry = entryNo;
    });
  }

  void _onlineDatabase() async {
    isLoading = true;
    final url = Uri.https(
      'shoppinglist-81ab6-default-rtdb.firebaseio.com',
      'blog_entries.json',
    );
    final response = await http.get(url);

    if (response.statusCode >= 400 || response.body == 'null') {
      print('Error retreiving data');
      return;
    }

    final Map<String, dynamic> responseData = json.decode(response.body);

    // response format : {-OqPoJd95Hafu2jrU0Zq: {likes: 0, title: Starting up a blog to share progress!}, -OqPoKl1-QRWpsxsKXGI: {likes: 0, title: Progress report on Flutter development.}}
    for (var resDataEntry in responseData.entries) {
      _loadedList.add(
        EntryData(
          id: resDataEntry.key,
          title: resDataEntry.value['title'],
          subtitle: resDataEntry.value['subtitle'],
          body: resDataEntry.value['body'],
          date: DateTime.parse(resDataEntry.value['date']),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _onlineDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Development Blog')),
      drawer: MainDrawer(changeEntry: _changeEntry, loadedList: _loadedList),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: EntryWidget(data: _loadedList[_activeEntry]),
        ),
      ),
    );
  }
}
