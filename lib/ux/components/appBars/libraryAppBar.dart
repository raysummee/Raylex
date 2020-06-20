import 'package:flutter/material.dart';

class LibraryAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
          alignment: Alignment.bottomLeft,
          height: 200,
          child: Text(
            "Library",
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
    );
  }
}