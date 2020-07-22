import 'dart:ui';

import 'package:flutter/material.dart';



class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  LibraryAppBar({this.title:"Library"});
  @override
  Widget build(BuildContext context) {
    return   AppBar(
          backgroundColor: Colors.lightBlue.withAlpha(200),
          title: Text(title)
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}