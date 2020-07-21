import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/components/dialog/editLyricsDialog.dart';
import 'package:Raylex/ux/pages/lyricsPage.dart';
import 'package:flutter/material.dart';

class PlayerAppBar extends StatelessWidget {
  final bool inLyrics;
  final PlayerLogic playerLogic;
  PlayerAppBar(this.playerLogic, {this.inLyrics:false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      alignment: Alignment.topLeft,
      child: Row(          
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                onPressed: (){
                  Navigator.of(context).pop();
                }
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "PLAYLIST",
                    style: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  Text(
                    "All songs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple
                    ),
                  ),
                ],
              )
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onSelected: (selected){
                  switch (selected) {
                    case 0:
                      print("selected add to liked");
                      break;
                    case 1:
                      print("selected equalizer");
                      break;
                    case 2:
                      if(!inLyrics){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=> LyricsPage(playerLogic))
                        );
                      }
                      break;
                    case 3:
                      showDialog(context: context, builder: (_)=>EditLyricsDialog());
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Add to Liked"),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text("Equalizer"),
                    value: 1,
                  ),
                  if(!inLyrics)...[
                    PopupMenuItem(
                      child: Text("Lyrics"),
                      value: 2,
                    )
                  ],
                  PopupMenuItem(
                    child: Text("Edit Lyrics"),
                    value: 3,
                  ),
                ]
              )
            )
          )
        ],
      )
    );
  }
}