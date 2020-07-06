import 'package:Raylex/logic/models/modelPlaylistData.dart';
import 'package:Raylex/ux/components/cards/roundedImageCard.dart';
import 'package:flutter/material.dart';

class HorizontalListRoundedImage extends StatelessWidget {
  final List<ModelPlaylistData> list= [
    ModelPlaylistData("Raylex Select","lib/assets/images/raylexselect.jpg", Future.value()),
    ModelPlaylistData("Top 200","lib/assets/images/top200.jpg", Future.value()),
    ModelPlaylistData("Top 100","lib/assets/images/top100s.jpg", Future.value()),
    ModelPlaylistData("Top 50","lib/assets/images/top50s.jpg", Future.value()),
    ModelPlaylistData("Top 10","lib/assets/images/top10s.jpg", Future.value()),
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