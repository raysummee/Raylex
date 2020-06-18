import 'package:flutter/material.dart';

class GroupPlayerAccControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.speaker,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  "Dan's Speaker",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: Icon(
                  Icons.shuffle,
                  color: Colors.blue,
                ),
              ),
              Icon(
                Icons.repeat,
                color: Colors.grey.shade600,
              )
            ],
          ),
        ],
      ),
    );
  }
}