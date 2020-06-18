import 'package:raylex/ux/pages/libraryPages.dart';
import 'package:raylex/ux/pages/playerUIPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavPages extends StatefulWidget {
  @override
  _NavPagesState createState() => _NavPagesState();
}

class _NavPagesState extends State<NavPages> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          LibraryPages(),
          PlayerUIPage()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
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