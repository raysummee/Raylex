import 'package:Raylex/logic/models/modelPlaylistData.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:Raylex/ux/components/cards/roundedImageCard.dart';
import 'package:flutter/material.dart';

class HorizontalListRoundedImage extends StatelessWidget {
  final List<ModelPlaylistData> list;
  HorizontalListRoundedImage(this.list);
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