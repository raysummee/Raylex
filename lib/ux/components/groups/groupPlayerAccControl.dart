import 'package:Raylex/logic/playerLogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GroupPlayerAccControl extends StatefulWidget {
  final PlayerLogic _playerLogic;
  GroupPlayerAccControl(this._playerLogic);

  @override
  _GroupPlayerAccControlState createState() => _GroupPlayerAccControlState();
}

class _GroupPlayerAccControlState extends State<GroupPlayerAccControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
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
                  "User's Speaker",
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
                    color: widget._playerLogic.shuffle?Colors.blue.shade900:Colors.grey.shade600,
                  ),
                  onPressed: (){
                    setState(() {
                      widget._playerLogic.shuffle = !widget._playerLogic.shuffle;
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  ((){
                    switch (widget._playerLogic.repeat) {
                      case 0:
                        return FlutterIcons.repeat_off_mco;
                        break;
                      case 1:
                        return FlutterIcons.repeat_mco;
                        break;
                      case 2:
                        return FlutterIcons.repeat_once_mco;
                        break;
                      default:
                        return FlutterIcons.repeat_off_mco;
                    }
                  }()),
                  color: widget._playerLogic.repeat!=0?Colors.blue.shade900:Colors.grey.shade600,
                ),
                onPressed: (){
                  setState(() {
                    switch(widget._playerLogic.repeat){
                      case 0:
                        widget._playerLogic.repeat = 1;
                        break;
                      case 1:
                        widget._playerLogic.repeat = 2;
                        break;
                      case 2:
                        widget._playerLogic.repeat = 0;
                        break;
                    }
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}