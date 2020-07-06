import 'package:Raylex/logic/models/modelPlaylistData.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:Raylex/ux/components/cards/roundedImageCard.dart';
import 'package:flutter/material.dart';

class HorizontalListRoundedImage extends StatelessWidget {
  static Future<dynamic> _future() async{
    return null;
  }
  final List<ModelPlaylistData> list= [
    ModelPlaylistData("Raylex Select", "lib/assets/images/raylexselect.jpg", _future),
    ModelPlaylistData("Top 200", "lib/assets/images/top200.jpg", _future),
    ModelPlaylistData("Top 100", "lib/assets/images/top100s.jpg", _future),
    ModelPlaylistData("Top 50", "lib/assets/images/top50s.jpg", _future),
    ModelPlaylistData("Top 10", "lib/assets/images/top10s.jpg", _future),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: list.length,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return RoundedImageCard(
            list.elementAt(index).imageuri,
            list.elementAt(index).title,
            list.elementAt(index).future
          );
        }
      ),
    );
  }
}