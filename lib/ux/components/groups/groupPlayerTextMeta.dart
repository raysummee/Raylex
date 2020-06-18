import 'package:flutter/material.dart';

class GroupPlayerTextMeta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Art Pop Demo",
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        Container(  
          margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
          alignment: Alignment.centerLeft,
          child: Text(
            "Lady Gaga".toUpperCase(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          )
        ),
      ],
    );
  }
}