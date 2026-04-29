import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/widgets/entry_widget.dart';
import 'package:github_blog/widgets/main_drawer.dart';
import 'package:http/http.dart' as http;

class DesktopWidget extends StatefulWidget {
  const DesktopWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DestopWidget();
  }
}

class _DestopWidget extends State<DesktopWidget> {
  var _activeEntry = 0;
  final List<EntryData> _loadedList = [];
  var isLoading = false;

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
    //final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;

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
      drawer: MainDrawer(changeEntry: _changeEntry, loadedList: _loadedList),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: [
              SizedBox(height: 100),
              if (!isLoading) EntryWidget(data: _loadedList[_activeEntry]),
              if (isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
