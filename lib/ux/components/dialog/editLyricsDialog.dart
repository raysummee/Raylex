import 'package:Raylex/logic/lyricsDb.dart';
import 'package:Raylex/logic/models/modelLyrics.dart';
import 'package:Raylex/logic/models/notifyLyrics.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLyricsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      
    var appstatelist = Provider.of<PlayerStateNotify>(context);
    var appstatepos = Provider.of<PlaylistPosition>(context);
    var appstateLyrics = Provider.of<NotifyLyrics>(context);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Lyrics here",
                filled: true,
                fillColor: Colors.grey[400],
                
              ),
              onChanged: (lyrics)=>appstateLyrics.lyrics = lyrics
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey[400],
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              child: Text("Save"),
              onPressed:(){
                ModelLyrics modelLyrics = new ModelLyrics(
                  id: 1,
                  artistName: appstatelist.songinfos.elementAt(appstatepos.index).artist,
                  songName: appstatelist.songinfos.elementAt(appstatepos.index).title,
                  lyrics: appstateLyrics.lyrics
                );
                LyricsDb().insertProduct(modelLyrics);
                Navigator.of(context).pop();
              } 
            ),
          )
        ],
      ),
    );
  }
}