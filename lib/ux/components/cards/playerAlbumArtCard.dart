import 'dart:async';
import 'dart:io';

import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerAlbumArtCard extends StatefulWidget {
  @override
  _PlayerAlbumArtCardState createState() => _PlayerAlbumArtCardState();
}

class _PlayerAlbumArtCardState extends State<PlayerAlbumArtCard> {
  
  StreamSubscription _playlistPositionSubscription;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    
  }

  @override
  void dispose(){
    super.dispose();
    _playlistPositionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var appstatelist = Provider.of<PlayerStateNotify>(context);
    var appstatepos = Provider.of<PlaylistPosition>(context);
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
            image: appstatelist.songinfos!=null&&appstatelist.songinfos.elementAt(appstatepos.index).albumArt!=null?FileImage(File(appstatelist.songinfos.elementAt(appstatepos.index).albumArt)):AssetImage("lib/assets/images/white-headphone.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}