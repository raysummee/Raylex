import 'package:raylex/ux/components/appBars/playerAppBar.dart';
import 'package:raylex/ux/components/cards/playerAlbumArtCard.dart';
import 'package:raylex/ux/components/groups/groupPlayerAccControl.dart';
import 'package:raylex/ux/components/groups/groupPlayerControl.dart';
import 'package:raylex/ux/components/groups/groupPlayerTextMeta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerUIPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
    );
  }
}