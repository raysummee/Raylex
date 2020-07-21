import 'dart:ffi';

import 'package:Raylex/logic/lyricsDb.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardLyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appstatelist = Provider.of<PlayerStateNotify>(context);
    var appstatepos = Provider.of<PlaylistPosition>(context);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 2
          )
        ]
      ),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: LyricsDb().specificLyrics(
            appstatelist.songinfos.elementAt(appstatepos.index).title,
            appstatelist.songinfos.elementAt(appstatepos.index).artist,
          ),
          builder: (context, snapshot) {
            if(snapshot.data!=null)
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: double.infinity,
                child: Text(
                  snapshot.data
                ),
              );
            else
              return Text("Loading");
          }
        ),
      ),
    );
  }
}