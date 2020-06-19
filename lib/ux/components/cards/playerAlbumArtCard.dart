import 'package:flutter/material.dart';

class PlayerAlbumArtCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 4)
          )
        ]
      ),
      width: MediaQuery.of(context).size.width-50,
      height: MediaQuery.of(context).size.width-80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image(
          image: AssetImage("lib/assets/images/ZUWOqcT.jpg"),
          fit: BoxFit.cover,
        ),
      )
    );
  }
}