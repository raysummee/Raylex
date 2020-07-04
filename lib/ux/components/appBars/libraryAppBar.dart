import 'dart:ui';

import 'package:flutter/material.dart';



class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget{
  
  @override
  Widget build(BuildContext context) {
    return   AppBar(
          backgroundColor: Colors.lightBlue.withAlpha(200),
          title: Text("Library")
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}