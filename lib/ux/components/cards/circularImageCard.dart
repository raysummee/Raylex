import 'dart:math';

import 'package:flutter/material.dart';

class CircularImageCard extends StatelessWidget {
  final String title;
  CircularImageCard(this.title);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
          height: 110,
          width: 110,
          margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)),
            borderRadius: BorderRadius.circular(70),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(70),
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.blue.withOpacity(0.5),
            splashColor: Colors.blue.withOpacity(0.5),
            onTap: (){Navigator.pushNamed(context, "playerUI");},
            borderRadius: BorderRadius.circular(70),
            child: Container(  
              margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
              height: 110,
              width: 110,
            ),
          ),
        ),
      ],
    );
  }
}