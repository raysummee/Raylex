
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/components/appBars/playerAppBar.dart';
import 'package:Raylex/ux/components/cards/playerAlbumArtCard.dart';
import 'package:Raylex/ux/components/groups/groupPlayerAccControl.dart';
import 'package:Raylex/ux/components/groups/groupPlayerControl.dart';
import 'package:Raylex/ux/components/groups/groupPlayerTextMeta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlayerUIPage extends StatelessWidget{
  final PlayerLogic _playerLogic;
  PlayerUIPage(this._playerLogic);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //the top portion playlist name, back, menu consist here
            PlayerAppBar(_playerLogic),
            //the album art is consist here
            PlayerAlbumArtCard(),
            //song name and artist name here
            GroupPlayerTextMeta(),
            //basics controls like seek, play pause, next, previous
            GroupPlayerControl(_playerLogic),
            //acco controls like mute speaker of headset set shuffle and repeats
            GroupPlayerAccControl(_playerLogic),
          ],
        ),
      ),
    );
  }
}