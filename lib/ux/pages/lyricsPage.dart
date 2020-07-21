import 'package:Raylex/logic/playerLogic.dart';
import 'package:Raylex/ux/components/appBars/playerAppBar.dart';
import 'package:Raylex/ux/components/button/btnAnimatedPlayPause.dart';
import 'package:Raylex/ux/components/cards/cardLyrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LyricsPage extends StatelessWidget {
  final PlayerLogic _playerLogic;
  LyricsPage(this._playerLogic);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PlayerAppBar(_playerLogic, inLyrics: true,),
            Expanded(
              child: CardLyrics()
            ),
            BtnAnimatedPlayPause(_playerLogic)
          ],
        ),
      ),
    );
  }
}