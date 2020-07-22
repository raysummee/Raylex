import 'package:Raylex/logic/loveDb.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/ux/components/lists/songList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FutureLoveSongList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<PlayerStateNotify>(context, listen: false);
    return FutureBuilder(
      future: LoveDb().allLove(),
      builder: (context, snap){
        if(snap.data!=null){
          List<SongInfo> songinfos = snap.data;
          if(songinfos.isNotEmpty)
            return SongList(songinfos,isInLovePlaylist: true,);
          else
            return Center(child: Text("Mark heart to have song here"),);
        }else{
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}