import 'package:raylex/ux/components/appBars/welcomeHomeRow.dart';
import 'package:raylex/ux/components/lists/horizontalRoundedList.dart';
import 'package:flutter/material.dart';

class LibraryPages extends StatelessWidget {
  final List<String> list = ["Zubeen Garg", "Sonu Nigam", "Justin Beiber", "ED Sheeran", "Ariana Grand"];
  final List<String> listAlbums = ["Misson China", "Dil Jaale", "Sorry", "Safaar", "Promises"];
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innnerScroll){
        return <Widget>[
          WelcomeHomeRow(),
        ];
      },
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HorizontalRoundedList(
              headerName: "Artists",
              contentList: list,
            ),
            HorizontalRoundedList(
              headerName: "Albums",
              contentList: listAlbums,
            ),
          ],
        ),
      )
    );
  }
}