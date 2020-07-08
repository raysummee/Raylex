import 'package:Raylex/logic/models/modelGroupPlaylistData.dart';
import 'package:Raylex/logic/models/modelPlaylistData.dart';
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
  static Future<dynamic> _future() async{
    return null;
  }
  static final List<ModelPlaylistData> list= [
    ModelPlaylistData("Raylex Select", "lib/assets/images/raylexselect.jpg", _future),
    ModelPlaylistData("Top 200", "lib/assets/images/top200.jpg", _future),
    ModelPlaylistData("Top 100", "lib/assets/images/top100s.jpg", _future),
    ModelPlaylistData("Top 50", "lib/assets/images/top50s.jpg", _future),
    ModelPlaylistData("Top 10", "lib/assets/images/top10s.jpg", _future),
  ];
  static final List<ModelPlaylistData> list1= [
    ModelPlaylistData("Top 200", "lib/assets/images/superdupersongs.jpg", _future),
    ModelPlaylistData("Top 100", "lib/assets/images/top100s.jpg", _future),
    ModelPlaylistData("Top 50", "lib/assets/images/top50s.jpg", _future),
    ModelPlaylistData("Top 10", "lib/assets/images/top10s.jpg", _future),
  ];
  final List<ModelGroupPlaylistData> groupList = [
    ModelGroupPlaylistData("Raylex Exclusive", list),
    ModelGroupPlaylistData("Dance", list1),

  ];
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
        padding: EdgeInsets.fromLTRB(0, 10, 0, 70),
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
                  future: SongQuery.allSongs,
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
          
          //HorizontalListRoundedImage(),
          
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupList.length,
              itemBuilder: (context, index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 5, 10, 0),
                      child: Text(
                        groupList.elementAt(index).groupTitle.toUpperCase(),
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        )
                      ),
                    ),
                    HorizontalListRoundedImage(groupList.elementAt(index).list),
                  ],
                );
              }
            ),
          
        ],
      ) 
    );
  }
}