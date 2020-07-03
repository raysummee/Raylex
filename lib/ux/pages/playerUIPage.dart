import 'dart:ui';

import 'package:Raylex/logic/models/modelMiniplayer.dart';
import 'package:Raylex/logic/models/playerStateNotify.dart';
import 'package:Raylex/logic/models/playlistPosition.dart';
import 'package:Raylex/logic/models/songInfo.dart';
import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/components/appBars/playerAppBar.dart';
import 'package:Raylex/ux/components/cards/miniPlayer.dart';
import 'package:Raylex/ux/components/cards/playerAlbumArtCard.dart';
import 'package:Raylex/ux/components/groups/groupPlayerAccControl.dart';
import 'package:Raylex/ux/components/groups/groupPlayerControl.dart';
import 'package:Raylex/ux/components/groups/groupPlayerTextMeta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';


class PlayerUIPage extends StatelessWidget{
  final PlayerLogic _playerLogic;
  PlayerUIPage(this._playerLogic);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
          child: 
              Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //the top portion playlist name, back, menu consist here
                    PlayerAppBar(),
                    //the album art is consist here
                    PlayerAlbumArtCard(),
                    //song name and artist name here
                    GroupPlayerTextMeta(),
                    //basics controls like seek, play pause, next, previous
                    GroupPlayerControl(_playerLogic),
                    //acco controls like mute speaker of headset set shuffle and repeats
                    GroupPlayerAccControl(),
                  ],
                ),
              )
        ),
      );
  }
}