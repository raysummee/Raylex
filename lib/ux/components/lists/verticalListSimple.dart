import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/material.dart';

class VerticalListSimple extends StatelessWidget {
  final List<SongInfo> songinfo;
  VerticalListSimple(this.songinfo);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: songinfo.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(songinfo.elementAt(index).title),
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerUIPage(songinfo.elementAt(index).uri, songinfo.elementAt(index).duration))),
          );
        },
      ),
    );
  }
}