import 'dart:ui';

import 'package:Raylex/ux/components/lists/songList.dart';
import 'package:Raylex/ux/components/loader/futureSongList.dart';
import 'package:Raylex/ux/pages/libraryPages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AllSongsPage extends StatelessWidget {
  final String uri;
  final String title;
  final AsyncValueGetter future;
  AllSongsPage({
    this.uri: "lib/assets/images/white-headphone.jpg",
    this.title: "Playlist",
    @required this.future
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerscroll){
          return <Widget>[
            SliverAppBar(
              elevation: 1,
              bottom: PreferredSize(
                child: Text(""),
                preferredSize: Size.fromHeight(20),
              ),
              flexibleSpace: Container(
                child: FlexibleSpaceBar(
                    background: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          uri,
                          height: 140, 
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                ),
              ),
              expandedHeight: 250,
              backgroundColor: Colors.lightBlue.shade400,
              centerTitle: true,
              pinned: true,
             
              leading: IconButton(
                iconSize: 16,
                icon: Icon(
                  Icons.arrow_back_ios
                ), 
                onPressed: ()=>Navigator.of(context).pop()
              ),
              actions: <Widget>[
                IconButton(
                  iconSize: 21,
                  icon: Icon(FlutterIcons.heart_outline_mco),
                  onPressed: (){},
                  
                )
              ],
            )
          ];
        },
        body: FutureSongList(future),
      )
    );
  }
}