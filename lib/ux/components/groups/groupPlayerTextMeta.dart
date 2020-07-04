
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/ux/components/animations/marqueeWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GroupPlayerTextMeta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var appstatelist = Provider.of<PlayerStateNotify>(context);
    var appstatepos = Provider.of<PlaylistPosition>(context);
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 5),
          alignment: Alignment.centerLeft,
          child: MarqueeWidget(
            child: Text(
              appstatelist.songinfos!=null?
              appstatelist.songinfos.elementAt(appstatepos.index).title:"",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
        Container(  
          margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
          alignment: Alignment.centerLeft,
          child: MarqueeWidget(
            child: Text(
              appstatelist.songinfos!=null?
              appstatelist.songinfos.elementAt(appstatepos.index).artist.toUpperCase():"",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
      ],
    );
  }
}