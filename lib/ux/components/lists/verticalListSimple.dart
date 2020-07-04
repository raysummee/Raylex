
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalListSimple extends StatefulWidget {
  final List<SongInfo> songinfo;
  VerticalListSimple(this.songinfo);

  @override
  _VerticalListSimpleState createState() => _VerticalListSimpleState();
}

class _VerticalListSimpleState extends State<VerticalListSimple> {
  
  @override
  Widget build(BuildContext context) {
    var appstate = Provider.of<PlaylistPosition>(context);
    
    return Expanded(
      child: ListView.builder(
        itemCount: widget.songinfo.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
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
              PlayerLogic().playMusic(widget.songinfo.elementAt(index).uri);
              appstate.index = index;
            }
          );
        },
      ),
    );
  }
}