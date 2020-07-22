import 'dart:io';

import 'package:Raylex/logic/loveDb.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  final List<SongInfo> songinfos;
  final bool isInLovePlaylist;
  SongList(this.songinfos,{this.isInLovePlaylist:false});
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    var appstatepos = Provider.of<PlaylistPosition>(context);
    var appstatelist = Provider.of<PlayerStateNotify>(context);
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
                  itemCount: widget.songinfos.length,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  itemBuilder: (context, index){
                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      leading: Image(
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                        image: widget.songinfos!=null&&
                          widget.songinfos.elementAt(index).albumArt!=null&&
                          File(widget.songinfos.elementAt(index).albumArt).existsSync()?
                            FileImage(File(widget.songinfos.elementAt(index).albumArt)):
                            AssetImage("lib/assets/images/white-headphone.jpg"),
                      ),
                      title: Text(
                        widget.songinfos.elementAt(index).title,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 16,
                          color: appstatepos.index==index&&appstatelist.songinfos.elementAt(index).title==widget.songinfos.elementAt(index).title?Colors.red:Colors.black
                        ),
                      ),
                      subtitle: Text(
                        widget.songinfos.elementAt(index).artist,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 14,
                          
                        ),
                      ),
                      trailing: PopupMenuButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onSelected: (selected){
                          switch (selected) {
                            case 0:
                              SongInfo songInfo = widget.songinfos.elementAt(index);
                              LoveDb().insertLove(songInfo);
                              break;
                            case 2:
                              LoveDb().deleteLove(widget.songinfos.elementAt(index).id);
                              
                          }
                        },
                        itemBuilder: (context) => [
                          ((){
                            if(widget.isInLovePlaylist){
                              return PopupMenuItem(
                                child: Text("Delete from Liked"),
                                value: 2,
                              );
                            }else{
                              return PopupMenuItem(
                                child: Text("Add to Liked"),
                                value: 0,
                              );
                            }
                          }()),
                          PopupMenuItem(
                            child: Text("Play Next"),
                            value: 1,
                          ),
                        ]
                      ),
                      onTap: (){          
                        PlayerLogic().playMusic(widget.songinfos.elementAt(index).uri);
                        appstatelist.songinfos = widget.songinfos;
                        appstatepos.index = index;
                      },
                    );
                  }
                )
    );
  }
}