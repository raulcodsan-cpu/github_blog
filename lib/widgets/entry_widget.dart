import 'package:flutter/material.dart';
import 'package:github_blog/data/entry_data.dart';
import 'package:github_blog/widgets/like_button.dart';


class EntryWidget extends StatelessWidget {
  const EntryWidget({super.key, required this.data});

  final EntryData data;


  @override
  Widget build(BuildContext context) {
    


    return Container(
      height: 500,
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
            width: 700,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 0.5,
                ),
              ),
            ),
            child: Text(
              data.title, //Title of entry
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            height: 50,
            width: 700,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColorLight,
                  width: 0.5,
                ),
              ),
            ),
            child: Text(
              data.subtitle, //Subtitle of entry
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(8),
            height: 200,
            width: 700,
            child: Text(
              data.body, //Body of entry
              textAlign: TextAlign.left,
              maxLines: 20,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(height: 60),
          LikeButton(data: data),
        ],
      ),
    );
  }
}
