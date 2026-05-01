import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/widgets/like_button.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget({super.key, required this.data});

  final EntryData data;

  @override
  Widget build(BuildContext context) {
    String textWithBreaks = data.body.replaceAll(r'\n', '\n');

    return Container(
      //height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: 40,
            width: 750,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              //spacing: 10,
              children: [
                Expanded(
                  child: AutoSizeText(
                    data.title, //----------------------------------------- Title of entry
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 1,
                  ),
                ),
                Text(
                  "(${data.date.toString().substring(0, 10)})",
                  style: TextStyle(color: Colors.white30, fontSize: 12),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 5),
            height: 50,
            width: 750,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 0.5,
                ),
              ),
            ),
            child: AutoSizeText(
              data.subtitle, //----------------------------------------- Subtitle of entry
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
            ),
          ),
          Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(8),
            //height: 300,
            width: 750,
            child: Text(
              textWithBreaks, //------------------------------------------ Body of entry
              textAlign: TextAlign.left,
              maxLines: 40,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(height: 10),
          LikeButton(data: data),
        ],
      ),
    );
  }
}
