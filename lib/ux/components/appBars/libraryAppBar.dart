import 'dart:ui';

import 'package:flutter/material.dart';



class LibraryAppBar extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        bottom: false,
        top: false,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
          color: Colors.lightBlue.withAlpha(200),
              alignment: Alignment.bottomLeft,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      "Library",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ]
              ) 
            ),
          ),
        )
    );
  }
}