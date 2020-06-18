import 'package:flutter/material.dart';

class PlayerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      alignment: Alignment.topLeft,
      child: Row(          
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                onPressed: (){}
              ),
            )
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "PLAYLIST",
                    style: TextStyle(
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  Text(
                    "Songs that slaps",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.deepPurple
                    ),
                  ),
                ],
              )
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.more_vert), 
                onPressed: (){},
              ),
            )
          )
        ],
      )
    );
  }
}