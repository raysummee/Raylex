import 'package:Raylex/ux/pages/libraryPages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //body of the nav bar 
      body: IndexedStack(
        index: _currentIndex,
        //the body of the nav should be here index wise
        children: <Widget>[
          LibraryPages()
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
            backgroundColor: Colors.lightBlue,
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
                  Icons.history,
                ),
                title: Text(
                  "History",
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