import 'dart:async';
import 'dart:io';

import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';

class PlayerAlbumArtCard extends StatefulWidget {
  final List<SongInfo> songinfos;
  final int index;
  final PlayerLogic _playerLogic;
  PlayerAlbumArtCard(this.songinfos, this.index, this._playerLogic);

  @override
  _PlayerAlbumArtCardState createState() => _PlayerAlbumArtCardState();
}

class _PlayerAlbumArtCardState extends State<PlayerAlbumArtCard> {
  
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
      setState(() {
        index = pos;
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
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 4)
          )
        ]
      ),
      width: MediaQuery.of(context).size.width-50,
      height: MediaQuery.of(context).size.width-80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          color: Colors.white,
          child: Image(
            image: widget.songinfos.elementAt(index).albumArt!=null?FileImage(File(widget.songinfos.elementAt(index).albumArt)):AssetImage("lib/assets/images/white-headphone.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}