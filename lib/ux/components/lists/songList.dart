import 'dart:io';

import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  final List<SongInfo> songinfos;
  SongList(this.songinfos);
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    var appstatepos = Provider.of<PlaylistPosition>(context);
    return Container(
      child: ListView.builder(
                  itemCount: widget.songinfos.length,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Image(
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                        image: widget.songinfos!=null&&
                          widget.songinfos.elementAt(index).albumArt!=null&&
                          File(widget.songinfos.elementAt(index).albumArt).existsSync()?
                            FileImage(File(widget.songinfos.elementAt(index).albumArt)):
                            AssetImage("lib/assets/images/white-headphone.jpg"),
                      ),
                      title: Text(widget.songinfos.elementAt(index).title),
                      subtitle: Text(widget.songinfos.elementAt(index).artist),
                      onTap: (){          
                        PlayerLogic().playMusic(widget.songinfos.elementAt(index).uri);
                        appstatepos.index = index;
                      },
                    );
                  }
                )
    );
  }
}