import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/songQuery.dart';
import 'package:Raylex/ux/components/appBars/libraryAppBar.dart';
import 'package:Raylex/ux/components/appBars/welcomeHomeRow.dart';
import 'package:Raylex/ux/components/lists/horizontalRoundedList.dart';
import 'package:Raylex/ux/components/lists/verticalListSimple.dart';
import 'package:flutter/material.dart';

class LibraryPages extends StatefulWidget {
  @override
  _LibraryPagesState createState() => _LibraryPagesState();
}

class _LibraryPagesState extends State<LibraryPages> {
  final List<String> list = ["Zubeen Garg", "Sonu Nigam", "Justin Beiber", "ED Sheeran", "Ariana Grand"];

  final List<String> listAlbums = ["Misson China", "Dil Jaale", "Sorry", "Safaar", "Promises"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        LibraryAppBar(),
        FutureBuilder(
          initialData: "data",
          future: SongQuery.allSongs(),
          builder: (context, snap){
            List<SongInfo> list = snap.data;
            return  VerticalListSimple(list);
          }
        ),      
      ],
    );
  }
}