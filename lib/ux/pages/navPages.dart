import 'package:Raylex/logic/models/modelMiniplayer.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/ux/components/cards/miniPlayer.dart';
import 'package:Raylex/ux/pages/historyPage.dart';
import 'package:Raylex/ux/pages/libraryPages.dart';
import 'package:Raylex/ux/pages/likedPage.dart';
import 'package:Raylex/ux/pages/playerUIPage.dart';
import 'package:Raylex/ux/pages/searchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//nav pages 
class NavPages extends StatefulWidget {
  @override
  _NavPagesState createState() => _NavPagesState();
}

//nav pages state
class _NavPagesState extends State<NavPages> {
  //the default index and initialising index of the nav bar
  int _currentIndex = 0;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.white,
      //body of the nav bar 
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          IndexedStack(
            index: _currentIndex,
            //the body of the nav should be here index wise
            children: <Widget>[
              LibraryPages(),
              LikedPage(),
              HistoryPage(),
              SearchPage()
            ],
          ),
            MiniPlayer()
        ],
      ),
      //nav bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedFontSize: 12,
            iconSize: 40,
            backgroundColor: Colors.lightBlue.withAlpha(200),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_music,
                ),
                title: Text(
                  "Library",
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.heart_solid,
                ),
                title: Text(
                  "Liked",
                )
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                ),
                title: Text(
                  "Explore",
                )
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                title: Text(
                  "Search",
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}