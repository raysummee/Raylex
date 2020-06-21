import 'package:Raylex/ux/components/animations/marqueeWidget.dart';
import 'package:flutter/material.dart';

class GroupPlayerTextMeta extends StatelessWidget {
  final String songName;
  final String artistName;
  GroupPlayerTextMeta(this.songName, this.artistName);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 5),
          alignment: Alignment.centerLeft,
          child: MarqueeWidget(
            child: Text(
              songName,
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
        Container(  
          margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
          alignment: Alignment.centerLeft,
          child: MarqueeWidget(
            child: Text(
              artistName.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
      ],
    );
  }
}