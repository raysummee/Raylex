import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GroupPlayerAccControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                FlutterIcons.sound_ent,
                color: Colors.blue.shade900,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  "Dan's Speaker",
                  style: TextStyle(
                    color: Colors.blue.shade900,
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
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: IconButton(
                  icon: Icon(
                    FlutterIcons.shuffle_variant_mco,
                    color: Colors.blue.shade900,
                  ),
                  onPressed: (){},
                ),
              ),
              IconButton(
                icon: Icon(
                  FlutterIcons.repeat_off_mco,
                  color: Colors.grey.shade600,
                ),
                onPressed: (){},
              )
            ],
          ),
        ],
      ),
    );
  }
}