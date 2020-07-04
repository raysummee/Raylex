import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:Raylex/ux/components/lists/songList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FutureSongList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<PlayerStateNotify>(context);
    return FutureBuilder(
      future: SongQuery.allSongs(),
      builder: (context, snap){
        if(snap.data!=null){
          List<SongInfo> list = snap.data;
          appstate.songinfos = list;
          return  list.isNotEmpty?SongList(list):Expanded(
            child: Center(
              child: Text("No songs found"),
            )  
          );
        }else{
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: CupertinoActivityIndicator()),
              ],
            ),
          );
        }
      }
    );
  }
}