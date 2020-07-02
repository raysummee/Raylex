import 'dart:async';

import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalListSimple extends StatefulWidget {
  final List<SongInfo> songinfo;
  VerticalListSimple(this.songinfo);

  @override
  _VerticalListSimpleState createState() => _VerticalListSimpleState();
}

class _VerticalListSimpleState extends State<VerticalListSimple> {
  int currentPlaying;
  PlaylistPosition appstate;
  @override 
  void initState(){
    super.initState();
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(appstate==null)
    appstate = Provider.of<PlaylistPosition>(context);
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.songinfo.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemBuilder: (context, index){
          return ListTile(
            title: Text(
              widget.songinfo.elementAt(index).title,
              style: ((){
                if(appstate.index!=null && appstate.index == index){
                  return TextStyle(
                    color: Colors.pink.shade300,
                    fontWeight: FontWeight.bold
                  );
                }else{
                  return TextStyle();
                }
              }()),
            ),
            trailing: ((){
              if(appstate.index!=null && appstate.index == index)
                return Icon(
                      Icons.bubble_chart,
                      color: Colors.pink.shade300,
                    
                );
              else
                return Text("");
            }()),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => PlayerUIPage(widget.songinfo, index))
              );
              setState(() {
                currentPlaying = index;
              });
            }
          );
        },
      ),
    );
  }
}