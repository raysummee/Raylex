import 'package:Raylex/ux/components/lists/songList.dart';
import 'package:Raylex/ux/components/loader/futureLoveSongsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LikedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:AppBar(
          title: Text(
            "For your likes"
          ),
          backgroundColor: Colors.lightBlue.shade300,
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "Songs",
              ),
              Tab(
                text: "Playlists",
              )
            ]
          ),
        ),
        body: TabBarView(
          children: [
            FutureLoveSongList(),
            Center(child: Text("Nothing is here"),)
          ]
        ),
      ),
    );
  }
}