import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:Raylex/ux/components/appBars/libraryAppBar.dart';
import 'package:Raylex/ux/components/lists/verticalListSimple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibraryPages extends StatefulWidget {
  @override
  _LibraryPagesState createState() => _LibraryPagesState();
}

class _LibraryPagesState extends State<LibraryPages> {
  PlayerStateNotify appstate;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(appstate==null)
     appstate=Provider.of<PlayerStateNotify>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LibraryAppBar(),
        FutureBuilder(
          future: SongQuery.allSongs(),
          builder: (context, snap){
            if(snap.data!=null){
              List<SongInfo> list = snap.data;
              appstate.songInfos = list;
              return  list.isNotEmpty?VerticalListSimple(list):Expanded(
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
        ),      
      ],
    );
  }
}