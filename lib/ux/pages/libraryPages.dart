import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:Raylex/ux/components/appBars/libraryAppBar.dart';
import 'package:Raylex/ux/components/lists/horizontalListRoundedImage.dart';
import 'package:Raylex/ux/components/lists/songList.dart';
import 'package:Raylex/ux/components/lists/verticalListSimple.dart';
import 'package:Raylex/ux/pages/allSongsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class LibraryPages extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerbox){
        return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Container(
                child: Text("Library"),
              ),
              backgroundColor: Colors.white,
              brightness: Brightness.light,
            )
        ];
      }, 
      body:ListView(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
        children: <Widget>[
          ListTile(
            dense: true,
            title: Text(
              "Playlists",
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: 21
              ),
            ),
            trailing: Icon(
              Icons.navigate_next
            ),
            onTap: (){},
          ),
          Divider(
            height: 0.2,
            thickness: 0.7,
            indent: 15,
          ),
          ListTile(
            dense: true,
            title: Text(
              "On Device",
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: 21
              ),
            ),
            trailing: Icon(
              Icons.navigate_next
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=> AllSongsPage(
                  title: "All Songs",
                  future: SongQuery.allSongs(),
                )
              ));
            },
          ),
          Divider(
            height: 0.2,
            thickness: 0.7,
            indent: 15,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 20, 10, 0),
            child: Text(
              "Lets Stream".toUpperCase(),
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12
              )
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 5, 10, 5),
            child: Text(
              "Raylex Exclusive".toUpperCase(),
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )
            ),
          ),
          HorizontalListRoundedImage()
        ],
      ) 
    );
  }
}