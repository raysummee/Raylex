import 'dart:async';

import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/components/animations/marqueeWidget.dart';
import 'package:flutter/material.dart';

class GroupPlayerTextMeta extends StatefulWidget {
  final List<SongInfo> songinfos;
  final int index;
  final PlayerLogic _playerLogic;
  GroupPlayerTextMeta(this.songinfos, this.index, this._playerLogic);

  @override
  _GroupPlayerTextMetaState createState() => _GroupPlayerTextMetaState();
}

class _GroupPlayerTextMetaState extends State<GroupPlayerTextMeta> {
  StreamSubscription _playlistPositionSubscription;
  int index;

  @override
  void initState(){
    super.initState();
    index = widget.index;
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _playlistPositionSubscription = widget._playerLogic.onPlaylistPositionChanged.listen((pos) {
      print("playertext playlist pos changed");
      setState(() {
        index  = pos;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    _playlistPositionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 5),
          alignment: Alignment.centerLeft,
          child: MarqueeWidget(
            child: Text(
              widget.songinfos.elementAt(index).title,
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
              widget.songinfos.elementAt(index).artist.toUpperCase(),
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