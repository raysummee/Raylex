import 'package:Raylex/ux/components/appBars/playerAppBar.dart';
import 'package:Raylex/ux/components/cards/playerAlbumArtCard.dart';
import 'package:Raylex/ux/components/groups/groupPlayerAccControl.dart';
import 'package:Raylex/ux/components/groups/groupPlayerControl.dart';
import 'package:Raylex/ux/components/groups/groupPlayerTextMeta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerUIPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PlayerAppBar(),
              PlayerAlbumArtCard(),
              GroupPlayerTextMeta(),
              GroupPlayerControl(),
              GroupPlayerAccControl(),
            ],
          )
        ),
      ),
    );
  }
}